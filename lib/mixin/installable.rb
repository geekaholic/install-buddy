require_relative 'utils'

module Installer
  module Installable
    def installer
      @installer ||= self.name.gsub(/Installer::/, '').downcase
    end

    def to_s
      "#{installer.capitalize} at work"
    end

    def install(package = '', dryrun = false)
      install_package(package, dryrun)
    end

    def install_package(package, dryrun)
      raise "Not implemented"
    end

    def run_install(cmd, package, dryrun)
      if dryrun
        puts Utils::colorize(cmd, :blue)
      elsif InstallBuddy.get_option(:remote)
        queue(cmd)
      else
        puts Utils::colorize("Installing #{package} via #{installer}...")
        system(cmd)
      end
    end

    def queue(cmd = '')
      @commands ||= []
      @commands << cmd
    end

    def remote_install
      @commands.each do |cmd|
        puts Utils::colorize("Executing #{cmd} remotely...")
        puts Remote.exec_batch(cmd) + "\n"
      end
      Remote.disconnect
    end

    # Override to check system dependencies before installing
    def dependency_met?
      true
    end
  end
end

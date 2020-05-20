require_relative 'mixin/installable'

module Installer
  class Apt
    extend Installable

    def self.to_s
      "Apt at work"
    end

    private
    def self.install_package(package = '', dryrun = false)
      puts Utils::colorize("Installing #{package} via apt...")
      cmd = "apt-get install -y #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

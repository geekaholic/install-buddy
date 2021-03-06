require_relative 'mixin/installable'

module Installer
  class Brew
    extend Installable

    def self.to_s
      "Homebrew"
    end

    def self.dependency_met?
      status = system('which brew')
      puts "Homebrew is required. Please install from http://brew.sh" unless status
      status
    end

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "brew install #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

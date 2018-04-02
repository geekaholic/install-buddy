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
    def self.install_package(package = '')
      puts "Installing #{package} via brew..."
      system("brew install #{package}")
    end
  end
end

require_relative 'mixin/installable'

module Installer
  class Dnf
    extend Installable

    def self.to_s
      "Dnf at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via dnf..."
      system("dnf install -y #{package}")
    end
  end
end

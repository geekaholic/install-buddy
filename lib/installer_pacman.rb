require_relative 'mixin/installable'

module Installer
  class Pacman
    extend Installable

    def self.to_s
      "Pacman at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via pacman..."
      system("pacman -Sy --noconfirm #{package}")
    end
  end
end

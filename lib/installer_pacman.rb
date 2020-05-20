require_relative 'mixin/installable'

module Installer
  class Pacman
    extend Installable

    def self.to_s
      "Pacman at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via pacman...")
      cmd = "pacman -Sy --noconfirm #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

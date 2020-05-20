require_relative 'mixin/installable'

module Installer
  class Dnf
    extend Installable

    def self.to_s
      "Dnf at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via dnf...")
      cmd = "dnf install -y #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

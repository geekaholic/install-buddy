require_relative 'mixin/installable'

module Installer
  class Gentoo
    extend Installable

    def self.to_s
      "Gentoo at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via portage...")
      cmd = "emerge --ask n #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

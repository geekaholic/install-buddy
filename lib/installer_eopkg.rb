require_relative 'mixin/installable'

module Installer
  class Eopkg
    extend Installable

    def self.to_s
      "Eopkg at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via eokpg...")
      cmd = "eopkg install -y #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

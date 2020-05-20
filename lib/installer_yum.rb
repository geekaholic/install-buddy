require_relative 'mixin/installable'

module Installer
  class Yum
    extend Installable

    def self.to_s
      "Yum at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via yum...")
      cmd = "yum install -y #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

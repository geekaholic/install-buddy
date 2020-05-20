require_relative 'mixin/installable'

module Installer
  class Alpine
    extend Installable

    def self.to_s
      "Alpine at work"
    end

    private
    def self.install_package(package = '')
      puts Utils::colorize("Installing #{package} via apk...")
      cmd = "apk add #{package}"
      if dryrun
        puts Utils::colorize(cmd, :blue)
      else
        system(cmd)
      end
    end
  end
end

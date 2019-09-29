require_relative 'mixin/installable'

module Installer
  class Alpine
    extend Installable

    def self.to_s
      "Alpine at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via apk..."
      system("apk add #{package}")
    end
  end
end

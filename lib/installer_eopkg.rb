require_relative 'mixin/installable'

module Installer
  class Eopkg
    extend Installable

    def self.to_s
      "Eopkg at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via eopkg..."
      system("eopkg install -y #{package}")
    end
  end
end

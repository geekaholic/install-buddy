require_relative 'mixin/installable'

module Installer
  class Yum
    extend Installable

    def self.to_s
      "Yum at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via yum..."
      system("yum install -y #{package}")
    end
  end
end

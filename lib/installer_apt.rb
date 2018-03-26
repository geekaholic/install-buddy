require_relative 'mixin/installable'

module Installer
  class Apt
    extend Installable

    def self.to_s
      "Apt at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via apt..."
      system("apt-get install -y #{package}")
    end
  end
end

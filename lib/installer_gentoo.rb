require_relative 'mixin/installable'

module Installer
  class Gentoo
    extend Installable

    def self.to_s
      "Gentoo at work"
    end

    private
    def self.install_package(package = '')
      puts "Installing #{package} via portage..."
      system("emerge --ask n #{package}")
    end
  end
end

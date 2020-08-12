require_relative 'mixin/installable'

module Installer
  class Pacman
    extend Installable

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "pacman -Sy --noconfirm #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

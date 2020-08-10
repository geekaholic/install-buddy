require_relative 'mixin/installable'

module Installer
  class Dnf
    extend Installable

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "dnf install -y #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

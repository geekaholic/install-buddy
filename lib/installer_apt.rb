require_relative 'mixin/installable'

module Installer
  class Apt
    extend Installable

    private
    def self.install_package(package = '', dryrun = false, args = nil)
      cmd = "apt-get install -y #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

require_relative 'mixin/installable'

module Installer
  class Eopkg
    extend Installable

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "eopkg install -y #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

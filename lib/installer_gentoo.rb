require_relative 'mixin/installable'

module Installer
  class Gentoo
    extend Installable

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "emerge --ask n #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

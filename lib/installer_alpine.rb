require_relative 'mixin/installable'

module Installer
  class Alpine
    extend Installable

    private
    def self.install_package(package = '', dryrun = false)
      cmd = "apk add #{package}"
      run_install(cmd, package, dryrun)
    end
  end
end

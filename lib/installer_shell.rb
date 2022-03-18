require_relative 'mixin/installable'

module Installer
  class Shell
    extend Installable

    private
    def self.install_package(package = '', dryrun = false, args)
      # TODO: For now we only support one shell command even though an array was passed
      cmd = args.first
      run_install(cmd, package, dryrun)
    end
  end
end


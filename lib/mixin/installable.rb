require_relative 'utils'

module Installer
  module Installable
    def install(package = '', dryrun = false)
      install_package(package, dryrun)
    end

    def install_package(package, dryrun)
      raise "Not implemented"
    end

    # Override to check system dependencies before installing
    def dependency_met?
      true
    end
  end
end

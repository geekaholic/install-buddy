module Installer
  module Installable
    def install(package = '')
      install_package(package)
    end

    def install_package(package)
      raise "Not implemented"
    end

    # Override to check system dependencies before installing
    def dependency_met?
      true
    end
  end
end

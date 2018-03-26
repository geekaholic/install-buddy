module Installer
  module Installable
    def install(package = '')
      install_package(package)
    end

    def install_package(package)
      raise "Not implemented"
    end
  end
end

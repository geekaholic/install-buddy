require_relative 'installers'

class DistroSupport
  # Distro/Distro families supported
  @@INSTALLERS = {
    :DEBIAN => Installer::Apt,
    :FEDORA =>  Installer::Dnf,
    :SOLUS => Installer::Eopkg
  }.freeze

  def self.supported?(distro_family = nil)
    !!installer(distro_family)
  end

  def self.installer(distro_family)
    @@INSTALLERS[distro_family.upcase.to_sym]
  end
end

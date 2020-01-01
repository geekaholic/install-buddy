require_relative 'installers'

class DistroSupport
  # Distro/Distro families supported
  @@INSTALLERS = {
    :DEBIAN => Installer::Apt,
    :UBUNTU => Installer::Apt,
    :CENTOS =>  Installer::Yum,
    :FEDORA =>  Installer::Dnf,
    :SOLUS => Installer::Eopkg,
    :ARCHLINUX => Installer::Pacman,
    :ALPINE => Installer::Alpine,
    :GENTOO => Installer::Gentoo,
    :MACOSX => Installer::Brew
  }.freeze

  def self.supported?(distro_family, distro = nil)
    # Check if we support distro_family or distro
    !!installer(distro_family, distro)
  end

  def self.installer(distro_family, distro = nil)
    @@INSTALLERS[distro_family.upcase.to_sym] ||
      (distro && @@INSTALLERS[distro.upcase.to_sym])
  end
end

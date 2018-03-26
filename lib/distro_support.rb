require_relative 'installers'

class DistroSupport
  # Distro/Distro families supported
  @@DISTROS = [
    :DEBIAN,
    :SOLUS
  ].freeze

  @@INSTALLERS = {
    :DEBIAN => Installer::Apt,
    :SOLUS => Installer::Eopkg
  }.freeze

  def self.supported?(distro_family = nil)
    @@DISTROS.include?(distro_family.upcase.to_sym)
  end

  def self.installer(distro_family)
    @@INSTALLERS[distro_family.upcase.to_sym]
  end
end

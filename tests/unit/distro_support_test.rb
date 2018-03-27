require 'minitest/autorun'
require_relative '../../lib/distro_support'
require_relative '../../lib/installers'

class  DistroSupportTest < Minitest::Test

  def test_if_distro_family_supported
    assert_equal DistroSupport.supported?(:DEBIAN), true
  end

  def test_if_distro_family_not_supported
    assert_equal DistroSupport.supported?(:XYZ), false
  end

  def test_gets_correct_installer
    assert_same DistroSupport.installer(:DEBIAN), Installer::Apt
  end

  def test_distro_family_takes_precedence
    assert_same DistroSupport.installer(:DEBIAN, :FEDORA), Installer::Apt
  end

  def test_if_fallbacks_to_distro
    # Fallback to distro if distro_family isn't supported
    assert_same DistroSupport.installer(:XYZ, :DEBIAN), Installer::Apt
  end

end

require 'minitest/autorun'
require_relative '../lib/distro_support'
require_relative '../lib/installers'

class  DistroSupportTest < Minitest::Test

  def test_reports_if_distro_family_supported
    assert_equal DistroSupport.supported?(:DEBIAN), true
  end

  def test_reports_if_distro_family_not_supported
    assert_equal DistroSupport.supported?(:XYZ), false
  end

  def test_gets_correct_installer
    assert_same DistroSupport.installer(:DEBIAN), Installer::Apt
  end
end

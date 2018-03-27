require 'minitest/autorun'
require_relative '../../lib/sysinfo'

class  SysinfoTest < Minitest::Test

  def test_detect_distro_from_good_os_release
    # Sets distro and distro_family correctly
    si = Sysinfo.new
    stubbed_resp = ["/etc/os-release", "NAME=\"Ubuntu\"", "ID=ubuntu", "ID_LIKE=debian"]
    si.stub :get_linux_release_data, stubbed_resp do
      si.send(:detect_distro)
      assert_equal si.distro, :UBUNTU
      assert_equal si.distro_family, :DEBIAN
    end
  end

  def test_sets_UNKNOWN_from_bad_os_release
    # Sets distro and distro_family to :UNKNOWN
    si = Sysinfo.new
    stubbed_resp = []
    si.stub :get_linux_release_data, stubbed_resp do
      si.send(:detect_distro)
      assert_equal si.distro, :UNKNOWN
      assert_equal si.distro_family, :UNKNOWN
    end
  end

  def test_sets_distro_family_from_distro
    # When distro_family is UKNOWN will set to same as distro
    si = Sysinfo.new
    stubbed_resp = ["/etc/os-release", "NAME=\"Ubuntu\"", "ID=ubuntu"]
    si.stub :get_linux_release_data, stubbed_resp do
      si.send(:detect_distro)
      assert_equal si.distro, :UBUNTU
      assert_equal si.distro_family, :UBUNTU
    end
  end

  def test_sets_distro_family_correctly
    # Sets distro_family correctly even if distro is UNKNOWN
    si = Sysinfo.new
    stubbed_resp = ["/etc/os-release", "ID_LIKE=debian"]
    si.stub :get_linux_release_data, stubbed_resp do
      si.send(:detect_distro)
      assert_equal si.distro, :UNKNOWN
      assert_equal si.distro_family, :DEBIAN
    end
  end

end

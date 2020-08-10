require 'minitest/autorun'
require 'yaml'
require_relative '../../lib/install_buddy'

def packagelist_hash
  yaml_good = <<~YML
    packages:
      - the_silver_searcher:
        - alias: { Debian: "silversearcher-ag", Solus: "silver-searcher"}
        - skip: [ "CentOS", "Fedora" ]
      - snapd:
        - only: [ "Ubuntu" ]
  YML
  YAML.load(yaml_good)
end

class InstallBuddyTest < Minitest::Test

  def test_package_list_is_valid
    yaml_good = <<~YML
      packages:
        - vim
        - git
    YML

    yaml = YAML.load(yaml_good)
    assert_equal InstallBuddy.valid_packagelist?(yaml), true

    yaml_bad = <<~YML
      - vim
      - git
    YML

    yaml = YAML.load(yaml_bad)
    assert_equal InstallBuddy.valid_packagelist?(yaml), false
  end

  # Passing a package name as string should just return it as is
  def test_resolve_package_returns_string_as_is
    pkg_in = "Foo"
    pkg_out = InstallBuddy.resolve_package(pkg_in, :DEBIAN, :DEBIAN)
    assert_instance_of String, pkg_out
    assert_equal pkg_in, pkg_out
  end

  # Passing in proper pkg hash will be processed correctly and return String
  def test_resolve_package_handles_meta_hash_data
    pkg_hash = packagelist_hash
    pkg = pkg_hash["packages"].first
    pkg_name = InstallBuddy.resolve_package(pkg, :DEBIAN, :DEBIAN)
    assert_instance_of String, pkg_name
  end

  # Passing pkg hash with distro_family will return correct pkg alias
  def test_resolve_package_matches_distro_family
    pkg_hash = packagelist_hash
    pkg = pkg_hash["packages"].first
    pkg_name = InstallBuddy.resolve_package(pkg, :DEBIAN)
    assert_instance_of String, pkg_name
    assert_equal pkg_name, "silversearcher-ag"
  end
 
  # Passing pkg hash that doesn't have an alias for distro/distro_family will return default pkg name
  def test_resolve_package_does_not_match_distro_family
    pkg_hash = packagelist_hash
    pkg = pkg_hash["packages"].first
    pkg_name = InstallBuddy.resolve_package(pkg, :XYZ, :ABC)
    assert_instance_of String, pkg_name
    assert_equal pkg_name, "the_silver_searcher"
  end

  # Should skip installation on a distro which should be skipped
  def test_skip_install_feature
    pkg_hash = packagelist_hash
    pkg = pkg_hash["packages"].first
    assert_equal InstallBuddy.skip_install?(pkg, :CENTOS), true
  end

  # Should skip Linux distro when in skip list even if distro's name or family does not match the word Linux
  def test_skip_linux_with_linux_distro
    yml = <<~YML
      packages:
        - macvim:
          - skip: [ "Linux" ]
    YML
    pkg_hash = YAML.load(yml)
    pkg = pkg_hash["packages"].first
    assert_equal InstallBuddy.skip_install?(pkg, :UBUNTU, :ELEMENTARY, :LINUX), true
  end

  # Should skip install if all unknwon
  def test_skip_with_all_unknown
    yml = <<~YML
      packages:
        - macvim:
          - skip: [ "Linux" ]
    YML
    pkg_hash = YAML.load(yml)
    pkg = pkg_hash["packages"].first
    assert_equal InstallBuddy.skip_install?(pkg, :UNKNOWN, :UNKNOWN, :UNKNOWN), true
  end

  # Should skip installation when only key present and does not match
  def test_only_install_feature
    pkg_hash = packagelist_hash
    pkg = pkg_hash["packages"].last
    assert_equal InstallBuddy.skip_install?(pkg, :DEBIAN), true
    assert_equal InstallBuddy.skip_install?(pkg, :UBUNTU), false
  end
end

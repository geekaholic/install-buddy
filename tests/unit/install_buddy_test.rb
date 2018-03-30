require 'minitest/autorun'
require 'yaml'
require_relative '../../lib/install_buddy'

def packagelist_hash
  yaml_good = <<~YML
    packages:
      - the_silver_searcher:
        - alias: { Debian: "silversearcher-ag", Solus: "silver-searcher"}
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
end

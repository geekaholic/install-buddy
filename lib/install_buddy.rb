class InstallBuddy
  @@OPTIONS = nil
  @@USAGE_STR = "Usage: install-buddy -f <package-list_file>"

  # Read command line options
  def self.parse_options
    @@OPTIONS ||= { packagelist: nil }

    OptionParser.new do |opts|
      # Banner used to show --help or -h
      opts.banner = @@USAGE_STR
      opts.separator "Installs packages listed in the package-list yaml file"
      opts.separator "Options:"
      opts.on("-f", "--file FILE", "Path to package-list yaml file") do |f|
        @@OPTIONS[:packagelist] = f
      end
    end.parse!
  end

  def self.get_option(key)
    parse_options unless @@OPTIONS
    @@OPTIONS[key]
  end

  def self.get_usage
    @@USAGE_STR
  end

  # Check obj is a valid package-list yml
  def self.valid_packagelist?(obj)
    obj.instance_of?(Hash) && !obj["packages"].nil?
  end

  # Resolve the name of the package depending on distro
  def self.resolve_package(pkg, distro_family, distro = nil)
    return pkg if(pkg.is_a?(String))

    # If not a string then must be a Hash
    raise "Not a valid package definition #{pkg}" unless(valid_pkg?(pkg))

    pkg_name = pkg.keys.first

    aliases = extract_key(pkg, :alias)
    # No alias key
    return pkg_name if(aliases.nil? || !aliases.is_a?(Hash))

    # Match against distro_family or distro
    aliases.each do |k, v|
      k = k.upcase.to_sym
      return v if (distro_family == k || distro == k)
    end

    # No match so naively return pkg_name
    pkg_name
  end

  # Should we skip installation?
  def self.skip_install?(pkg, distro_family, distro = nil)
    return false unless(valid_pkg?(pkg))

    skips = extract_key(pkg, :skip)
    # No skips key
    return false if(skips.nil? || !skips.is_a?(Array))

    skips = skips.map(&:upcase)
    skips.include?(distro_family.to_s) || skips.include?(distro.to_s)
  end

  private
  def self.valid_pkg?(pkg)
    (pkg.is_a?(Hash)) ? true : false
  end

  def self.extract_key(pkg, key)
    pkg_name = pkg.keys.first
    keys = pkg[pkg_name].select do |attr|
      attr.has_key?(key.to_s) || attr.has_key?(key)
    end.first

    # No key found
    (keys.nil?) ? nil : keys[key.to_s]
  end

end



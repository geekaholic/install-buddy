class InstallBuddy
  @@OPTIONS = nil
  @@USAGE_STR = "Usage: install-buddy -f <package-list_file> [--dry-run]"

  # Read command line options
  def self.parse_options
    @@OPTIONS ||= {
      packagelist: nil,
      remote: nil,
      debug: false,
      dryrun: false,
      noroot: false
    }

    OptionParser.new do |opts|
      # Banner used to show --help or -h
      opts.banner = @@USAGE_STR
      opts.separator "Installs packages listed in the package-list yaml file"
      opts.separator "Options:"
      opts.on("-f", "--file FILE", "Path to package-list yaml file") do |f|
        @@OPTIONS[:packagelist] = f
      end
      opts.on("-r", "--remote <ip_address>", "Remote SSH ip address configured with password-less login into root") do |ip|
        @@OPTIONS[:remote] = ip
      end
      opts.on("--debug", "Prints debug info for reporting bugs") do
        @@OPTIONS[:debug] = true
      end
      opts.on("--dry-run", "Pretends to install packages") do
        @@OPTIONS[:dryrun] = true
      end
      opts.on("--no-root", "Don't check if running as root (needed for homebrew)") do
        @@OPTIONS[:noroot] = true
      end
    end.parse!
    rescue => e
      abort("Bad option entered! Check your arguments.")
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
  def self.skip_install?(pkg, distro_family, distro = nil, os_type = nil)
    return false unless(valid_pkg?(pkg))

    # Skip intallation if :only key present and distro doesn't match
    if key_present?(pkg, :only)
      return only_install?(pkg, distro_family, distro) ? false : true
    end

    skips = extract_key(pkg, :skip)
    # No skip key
    return false if(skips.nil? || !skips.is_a?(Array))

    skips = skips.map(&:upcase)
    skips.include?(distro_family.to_s) || \
      skips.include?(distro.to_s) || \
      skips.include?(os_type.to_s) || \
      (distro_family == :UNKNOWN && distro == :UNKNOWN && os_type == :UNKNOWN)
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

  def self.key_present?(pkg, key)
    !!extract_key(pkg, key)
  end

  # Should we only install for this distro_family
  def self.only_install?(pkg, distro_family, distro = nil)
    return false unless(valid_pkg?(pkg))

    onlys = extract_key(pkg, :only)
    # No only key
    return false if(onlys.nil? || !onlys.is_a?(Array))

    onlys = onlys.map(&:upcase)
    onlys.include?(distro_family.to_s) || onlys.include?(distro.to_s)
  end

end



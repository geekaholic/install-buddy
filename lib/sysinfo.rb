class Sysinfo
  attr_reader :distro, :distro_family, :os_type

  def initialize
    @distro = @distro_family = @os_type = nil
    detect_distro
    detect_os
  end

  def self.term_supports_color?
    @colors ||= `env tput colors 2>/dev/null`.chomp
    @colors.to_i > 8
  end

  private
  def detect_distro
    out_arr = get_linux_release_data
    out_arr = get_osx_release_data if out_arr.empty?

    # os_type_arr -> ["ID=ubuntu", "VERSION_ID=\"16.04\"", "DISTRIB_ID=Ubuntu"]
    distro_type_arr = out_arr.grep(/ID/)
    if(distro_type_arr.any?)
      # Get distro name from ID or DISTRIB_ID and convert to uppercase
      begin
        @distro = distro_type_arr.grep(/^ID=|^DISTRIB_ID=/).compact.first.split('=')[1]
        @distro = cleanup_distro_name(@distro).upcase.to_sym
      rescue
        @distro = :UNKNOWN
      end
      begin
        @distro_family = distro_type_arr.grep(/ID_LIKE=/).first.split('=')[1]
        @distro_family = cleanup_distro_name(@distro_family).upcase.to_sym
      rescue
        # Defaults to same as @distro or UNKNOWN
        @distro_family = @distro
      end
    else
      @distro = :UNKNOWN
      @distro_family = :UNKNOWN
    end
    nil
  end


  def detect_os
    case RUBY_PLATFORM
    when /linux\-/
      @os_type = :LINUX
    when /darwin/
      @os_type = :OSX
    when /cygwin|mswin|mingw|bccwin|wince|emx/
      @os_type = :WINDOWS
    else
      @os_type = :UNKNOWN
    end
  end

  # Return /etc/{os-release, lsb-release} or similar
  def get_linux_release_data
    # Concat all file content
    cat = ''
    Dir.glob("/etc/**/*-release").each do |f|
      cat << File.read(f) if(File.file?(f))
    end
    cat.split(/\n/)
  end

  # Detect if running OSX
  def get_osx_release_data
    kernel = `uname -s`
    return ["ID=MacOSX"] if kernel.match(/^Darwin/)
    []
  end

  # cleanup and remove unwanted characters
  def cleanup_distro_name(word)
    word.gsub(/["']/,'')
  end

end

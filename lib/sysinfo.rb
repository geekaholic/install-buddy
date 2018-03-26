class Sysinfo
  attr_reader :distro, :distro_family

  def initialize
    @distro = @distro_family = nil
    detect_distro
  end

  private
  def detect_distro
    out_arr = get_linux_release_data

    # os_type_arr -> ["ID=ubuntu", "VERSION_ID=\"16.04\"", "DISTRIB_ID=Ubuntu"]
    os_type_arr = out_arr.grep(/ID/)
    if(os_type_arr.any?)
      # Get distro name from ID or DISTRIB_ID and convert to uppercase
      begin
        @distro = os_type_arr.grep(/^ID=|^DISTRIB_ID=/).compact.first.split('=')[1].upcase.to_sym
      rescue
        @distro = :UNKNOWN
      end
      begin
        @distro_family = os_type_arr.grep(/ID_LIKE=/).first.split('=')[1].upcase.to_sym
      rescue
        # Defaults to same as @distro or UNKNOWN
        @distro_family = @distro
      end
    else
      @distro = :UNKNOWN
      @distro_family = :UNKNOWN
    end
  end

  # Return /etc/{os-release, lsb-release} or similar
  def get_linux_release_data
    `find /etc/ -name \*-release -print -exec cat {} \\\; 2>/dev/null`.split(/\n/)
  end
end



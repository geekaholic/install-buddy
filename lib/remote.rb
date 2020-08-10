require 'net/ssh'

class Remote
  @ssh = nil
  @ip = InstallBuddy.get_option(:remote)
  @username = "root"

  def self.exec(cmd)
    Net::SSH.start(@ip, @username) do |ssh|
      return ssh.exec!(cmd)
    end
  rescue
    abort(Utils::colorize("Unable to connect to #{@ip} as #{@username}", :red))
  end

  def self.connect
    begin
      @ssh = Net::SSH.start(@ip, @username)
    rescue
      abort(Utils::colorize("Unable to connect to #{@ip} as #{@username}", :red))
    end
  end

  def self.exec_batch(cmd)
    @ssh ||= connect
    begin
      return @ssh.exec!(cmd)
    rescue
      abort(Utils::colorize("Unable to execute command #{cmd} on #{@ip}", :red))
    end
  end

  def self.disconnect
    @ssh.close
    @ssh = nil
  end
end

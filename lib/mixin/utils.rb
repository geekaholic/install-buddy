require_relative '../sysinfo'

module Utils
  extend self

  # Colorize output
  def colorize(text, color = :green)
    colors = {red: '31', green: '32', yellow: '33', blue: '34'}
    (Sysinfo::term_supports_color?) ? "\e[#{colors[color]}m#{text}\e[0m" : text
  end
end


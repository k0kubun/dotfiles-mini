Pry.editor = 'vim'

Pry.config.pager = false
prompt_procs = [
  proc { |target_self, nest_level, pry|
    input_method = (pry.respond_to?(:input_ring) ? :input_ring : :input_array)
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[\e[34m#{pry.public_send(input_method).size}\e[0m] \e[36m\e[1m#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}\e[0m (\e[32m\e[1m#{Pry.view_clip(target_self)}\e[0m)#{nested}> "
  },
  proc { |target_self, nest_level, pry|
    input_method = (pry.respond_to?(:input_ring) ? :input_ring : :input_array)
    nested = (nest_level.zero?) ?  '' : ":#{nest_level}"
    "[\e[34m#{pry.public_send(input_method).size}\e[0m] \e[36m\e[1m#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}\e[0m (\e[32m\e[1m#{Pry.view_clip(target_self)}\e[0m)#{nested}* "
  }
]
if Pry::Prompt.respond_to?(:new)
  Pry.config.prompt = Pry::Prompt.new('color', 'custom colored prompt', prompt_procs)
else
  Pry.config.prompt = prompt_procs
end

if defined?(PryByebug)
  aliases = {
    'n' => 'next',
    #'s' => 'step',
    'f' => 'finish',
    #'c' => 'continue',
  }

  require 'pry-byebug/version'
  if Gem::Version.new(PryByebug::VERSION) >= Gem::Version.new('3.4.0')
    aliases.merge!('bt' => 'backtrace')
  end

  aliases.each do |from, to|
    Pry::Commands.alias_command(from, to)
  end
end

Pry::Commands.alias_command('exit!', 'exit-program') # to hook at_exit

# def ppp(code)
#   puts Pry.Code(code).highlighted
# end

require 'time' # Time.parse
autoload :Base64, 'base64'
autoload :CSV, 'csv'
autoload :Digest, 'digest'
autoload :ERB, 'erb'
autoload :JSON, 'json'
autoload :Psych, 'psych'
autoload :Ripper, 'ripper'
autoload :Ripper, 'ripper'
autoload :SecureRandom, 'securerandom'
autoload :URI, 'uri'
autoload :YAML, 'yaml'

# frozen_string_literal: true

require_relative 'lib/cmd_executable/version'

Gem::Specification.new do |spec|
  spec.name          = 'cmd_executable'
  spec.version       = CmdExecutable::VERSION
  spec.authors       = ['Toshiki']
  spec.email         = ['toshiki.dev@protonmail.ch']

  spec.summary       = 'The command executable module.'
  spec.description   = <<-'DESC'
    This module adds a method "executable?(command)".
    it's return true if given command usable on Linux.
  DESC

  spec.homepage      = 'https://github.com/toshiki670/cmd_executable'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/toshiki670/cmd_executable'
  spec.metadata['changelog_uri'] = 'https://github.com/toshiki670/cmd_executable/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'pry-doc', '~> 1.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.85.0'

  spec.add_dependency 'thor', '~> 1.0'
end

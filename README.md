<a href="LICENSE" alt="MIT License"><img alt="GitHub" src="https://img.shields.io/github/license/toshiki670/cmd_executable?style=flat-square"></a>
<a href="https://github.com/toshiki670/cmd_executable/actions" alt="Check action"><img alt="GitHub" src="https://img.shields.io/github/workflow/status/toshiki670/cmd_executable/Ruby?label=Ruby&style=flat-square"></a>
<a href="https://rubygems.org/gems/cmd_executable" alt="Rubygems"><img alt="GitHub" src="https://img.shields.io/gem/dt/cmd_executable?style=flat-square"></a>
<a href="https://rubygems.org/gems/cmd_executable" alt="Rubygems"><img alt="GitHub" src="https://img.shields.io/gem/v/cmd_executable?style=flat-square"></a>

# CmdExecutable
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cmd_executable'
```

And then execute:

    `$ bundle install`

Or install it yourself as:

    `$ gem install cmd_executable`

## Usage
### as Module (include)
```
require 'cmd_executable'

class Klass
  include CmdExecutable

  def instance_method
    executable?('/bin/ls')
    executable?('ls')
    executable?(:ls)
    executable?('./bin/setup')
  end
end
```
### as Module method
```
CmdExecutable.executable?('/bin/ls')
CmdExecutable.executable?('ls')
CmdExecutable.executable?(:ls)
CmdExecutable.executable?('./bin/setup')
```

### as CLI
Check executable? :

    `$ cmd_executable -c [/path/to/command]`
    or
    `$ cmd_executable -c [../path/to/command]`
    or
    `$ cmd_executable -c [command]`

Show help :

    `$ cmd_executable -h`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub][source]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct][conduct].


## License

The gem is available as open source under the terms of the [MIT License][license].

## Code of Conduct

Everyone interacting in the CmdExecutable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct][conduct].

## Other links
- [Version History][version]

[source]:https://github.com/toshiki670/cmd_executable
[license]:https://github.com/toshiki670/cmd_executable/blob/master/LICENSE
[conduct]:https://github.com/toshiki670/cmd_executable/blob/master/CODE_OF_CONDUCT.md
[version]:https://github.com/toshiki670/cmd_executable/releases

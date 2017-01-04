# Logger2r

[![Gem Version](https://badge.fury.io/rb/logger2r.svg)](http://badge.fury.io/rb/logger2r)
[![Code Climate](https://codeclimate.com/github/skopciewski/logger2r/badges/gpa.svg)](https://codeclimate.com/github/skopciewski/logger2r)

Wrapper class for rubby Logger. Allow to initialize the Logger class for specific progname, and configure it based on yaml config. Inspired by Log4r's yamlconfigurator.


## Installation

Add this line to your application's Gemfile:

    gem 'logger2r'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logger2r

## Usage

Prepare yaml config file:

```yaml
---
:logger2r_config:
  :default:
    :severity_level: :info
    :device: "stdout"
  :MyClass:
    :severity_level: :warn
    :datetime_format: "%y-%m-%d"
```

```ruby
require "logger2r"
Logger2r.config_file = ...my_yaml_file...

class MyClass
  def initialize
    @logger = Logger2r.for_class(self.class.name)
  end
  def foo
    @logger.error "AAAA"
  end
end
```

## Versioning

See [semver.org][semver]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[semver]: http://semver.org/

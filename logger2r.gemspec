# coding: utf-8

begin
  require "./lib/logger2r/version"
rescue LoadError
  module Logger2r; VERSION = "0".freeze; end
end

Gem::Specification.new do |spec|
  spec.name          = "logger2r"
  spec.version       = Logger2r::VERSION
  spec.authors       = ["Szymon Kopciewski"]
  spec.email         = ["s.kopciewski@gmail.com"]
  spec.summary       = "Some extensions for ruby logger"
  spec.description   = "Some extensions for ruby logger"
  spec.homepage      = "https://github.com/skopciewski/logger2r"
  spec.license       = "GPL-3.0"

  spec.require_paths = ["lib"]
  spec.files         = Dir.glob("{bin,lib}/**/*") + \
                       %w(Gemfile LICENSE README.md CHANGELOG.md)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
end

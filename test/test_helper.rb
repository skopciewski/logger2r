require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "minitest/autorun"
require "minitest/reporters"

require "yaml"
require "fileutils"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

module TestHelper
  TESTS_DIR = File.expand_path(File.dirname(__FILE__))
  SUPPORT_DIR = File.join TESTS_DIR, "support"

  class Store
    CONFIG_PATH = File.join(SUPPORT_DIR, "sample_config.yml")

    def self.store_sample_config(config)
      File.open(CONFIG_PATH, "w") do |file|
        file.write config.to_yaml
      end
    end

    def self.remove_sample_config
      FileUtils.rm CONFIG_PATH
    end
  end
end

require "test_helper"
require "logger2r"

class TestFormatter < Logger::Formatter
  Format = "%s - %s".freeze
  def call(_severity, time, _progname, msg)
    Format % [format_datetime(time), msg2str(msg)]
  end
end

class Logger2rTest < Minitest::Test
  def setup
    sample_config = {
      logger2r_config: {
        default: {
          severity_level: :info,
          device: nil
        },
        :"Module::ClassFoo" => {
          severity_level: :warn,
          device: "stdout",
          datetime_format: "%y-%m-%d",
          formatter_class: "TestFormatter"
        }
      }
    }
    TestHelper::Store.store_sample_config(sample_config)
    ::Logger2r.config_file = nil
  end

  def teardown
    TestHelper::Store.remove_sample_config
  end

  def test_that_it_has_a_version_number
    refute_nil ::Logger2r::VERSION
  end

  def test_that_it_returns_correct_instance
    logger = ::Logger2r.for_class("ClassName")
    assert_equal ::Logger, logger.class
  end

  def test_that_it_returns_logger_with_default_level
    logger = ::Logger2r.for_class("ClassName")
    assert_equal 3, logger.level
  end

  def test_that_it_returns_logger_with_default_dateformat
    logger = ::Logger2r.for_class("ClassName")
    assert_nil logger.datetime_format
  end

  def test_that_it_returns_logger_with_default_formatter
    logger = ::Logger2r.for_class("ClassName")
    assert_nil logger.formatter
  end

  def test_that_it_returns_logger_with_right_progname
    logger = ::Logger2r.for_class("ClassName")
    assert_equal "ClassName", logger.progname
  end

  def test_that_logger_level_can_be_overwritten_by_default_cofig
    ::Logger2r.config_file = TestHelper::Store::CONFIG_PATH
    logger = ::Logger2r.for_class("ClassName")
    assert_equal 1, logger.level
  end

  def test_that_logger_level_can_be_overwritten_by_class_config
    ::Logger2r.config_file = TestHelper::Store::CONFIG_PATH
    logger = ::Logger2r.for_class("Module::ClassFoo")
    assert_equal 2, logger.level
  end

  def test_that_logger_dateformat_can_be_overwritten_by_class_config
    ::Logger2r.config_file = TestHelper::Store::CONFIG_PATH
    logger = ::Logger2r.for_class("Module::ClassFoo")
    assert_equal false, logger.datetime_format.nil?
  end

  def test_that_logger_formatter_can_be_overwritten_by_class_config
    ::Logger2r.config_file = TestHelper::Store::CONFIG_PATH
    logger = ::Logger2r.for_class("Module::ClassFoo")
    expect = "#{Time.now.strftime("%y-%m-%d")} - msg"
    assert_equal expect, logger.formatter.call("INFO", Time.now, "prog", "msg")
  end
end

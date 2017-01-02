require "test_helper"
require "logger2r"

class Logger2rTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Logger2r::VERSION
  end

  def test_that_it_returns_correct_instance
    logger = ::Logger2r.for_class_with_level("ClassName", :info)
    assert_equal ::Logger, logger.class
  end

  def test_that_it_returns_logger_with_right_level
    logger = ::Logger2r.for_class_with_level("ClassName", :info)
    assert_equal 1, logger.level
  end

  def test_that_it_returns_logger_with_right_progname
    logger = ::Logger2r.for_class_with_level("ClassName", :info)
    assert_equal 'ClassName', logger.progname
  end
end

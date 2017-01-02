require "test_helper"
require "logger2r"

class Logger2rTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Logger2r::VERSION
  end
end

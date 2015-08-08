require_relative 'test_helper'


class TestClass < Test::Unit::TestCase
  def test_script_method
  	assert_equal "HEJ", "HEJ"
  end
end
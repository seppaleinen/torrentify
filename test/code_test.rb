require_relative 'test_helper'

require_relative '../lib/code.rb'

class TestClass < Test::Unit::TestCase
  def test_test_method
  	result = test_method "hej"
  	assert_equal "HEJ", result
  end
end
#!/usr/bin/ruby
require_relative '../../test_helper'

require_relative '../../../lib/manager/sites/piratebay_parser'
require_relative '../../../lib/manager/mechanize_manager'

# Tests for kickass
class TestPirateBayClass < Test::Unit::TestCase
  def test_main_divs
    search_term = 'a pigeon sat on a branch reflecting on existence'
    page = MechanizeManager.new.search_piratebay(search_term)
    parser = PirateBayParser.new(page)
    result = parser.main_divs
    assert_not_nil result
    assert_false result.empty?
  end
end

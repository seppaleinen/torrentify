#!/usr/bin/ruby
require_relative '../../test_helper'

require_relative '../../../lib/manager/sites/extratorrent_parser'
require_relative '../../../lib/manager/mechanize_manager'

# Tests for kickass
class TestExtratorrentClass < Test::Unit::TestCase
  def test_connection_to_site
    search_term = 'a pigeon sat on a branch reflecting on existence'

    result = []

    assert_nothing_raised do
      result = MechanizeManager.new.search_extratorrent(search_term)
    end

    assert_not_nil result
    assert_false result.empty?
  end
end

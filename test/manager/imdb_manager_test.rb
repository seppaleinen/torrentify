#!/usr/bin/ruby
require_relative '../test_helper'

require_relative '../../lib/manager/imdb_manager'

# Tests for kickass
class TestExtratorrentClass < Test::Unit::TestCase
  def test_get_watchlist
    userid = 'ur32409321'
    manager = ImdbManager.new
    result = manager.get_watchlist(userid)
    assert_not_nil result
  end
end

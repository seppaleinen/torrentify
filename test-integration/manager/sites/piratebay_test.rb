#!/usr/bin/ruby
require_relative '../../test_helper'

require_relative '../../../lib/manager/sites/piratebay_parser'
require_relative '../../../lib/manager/mechanize_manager'

# Tests for kickass
class TestPirateBayClass < Test::Unit::TestCase
  def test_connection
    url = PirateBayParser::Parser::BASEURL

    assert_nothing_raised do
      MechanizeManager::Agent.get_web_page(url)
    end
  end

  def test_search_site
    search_term = 'a pigeon sat on a branch reflecting on existence'

    result = []

    assert_nothing_raised do
      result = MechanizeManager.new.search_piratebay(search_term)
    end

    assert_not_nil result
    assert_false result.empty?
  end

  def test_no_result
    search_term = 'asdasdasdasdasdasd'

    result = []

    assert_nothing_raised do
      result = MechanizeManager.new.search_piratebay(search_term)
    end

    assert_true result.empty?
  end
end

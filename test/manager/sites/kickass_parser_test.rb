#!/usr/bin/ruby
require_relative '../../test_helper'

require_relative '../../../lib/manager/sites/kickass_parser'
require_relative '../../../lib/manager/mechanize_manager'

# Tests for kickass
class TestKickassClass < Test::Unit::TestCase
  def test_main_divs
    search_term = 'a pigeon sat on a branch reflecting on existence'
    page = MechanizeManager.new.search_kickass(search_term)
    parser = KickassParser.new(page)
    out = capture_stdout do
      result = parser.main_divs
      assert_not_nil result
    end
    assert_not_nil out
  end
end

# Capture of stdout to STDOUT var
module Kernel
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
end

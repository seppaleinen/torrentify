#!/usr/bin/ruby
require_relative '../test_helper.rb'

require_relative '../../lib/sites/kickass_parser.rb'
require_relative '../../lib/mechanize_manager.rb'

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
    puts out.string
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

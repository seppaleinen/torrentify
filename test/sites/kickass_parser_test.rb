#!/usr/bin/ruby
require_relative '../test_helper.rb'

require_relative '../../lib/sites/kickass_parser.rb'
require_relative '../../lib/mechanize_manager.rb'

# Tests for kickass
class TestKickassClass < Test::Unit::TestCase
  def test_main_divs
    page = MechanizeManager.new.get_web_page('https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence/')
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

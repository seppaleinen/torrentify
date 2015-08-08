#!/usr/bin/ruby
require_relative '../test_helper.rb'

require_relative '../../lib/sites/kickass.rb'
require_relative '../../lib/code.rb'

# Tests for kickass
class TestKickassClass < Test::Unit::TestCase
  def test_hej
    page = get_web_page('https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence/')
    parser = KickassParser.new(page)
    result = parser.main_divs
    assert_not_nil result
    result.each do |link|
      puts link
    end
  end
end

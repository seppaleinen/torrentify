require_relative 'test_helper'

require_relative '../lib/torrentify'

# Tests for torrentify
class TestTorrentify < Test::Unit::TestCase
  def test_first
    search_param = 'Hej'
    Torrentify.search(search_param)
  end
end

#!/usr/bin/ruby
require_relative '../test_helper'

require_relative '../../lib/manager/imdb_manager'

# Tests for kickass
class TestImdbClass < Test::Unit::TestCase
  def test_get_watchlist
    userid = 'ur32409321'

    mock_request

    result = ImdbManager.new.get_watchlist(userid)

    assert_not_nil result
    assert_false result.empty?
  end

  def mock_request
    file_path = 'test_data/imdb_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'http://rss.imdb.com/user/ur32409321/watchlist')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end
end

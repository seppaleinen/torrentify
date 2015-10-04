#!/usr/bin/ruby
require_relative '../test_helper'

require_relative '../../lib/torrentify'

# Tests for kickass
class TestTorrentifyClass < Test::Unit::TestCase
  def test_search_all_return_best
    search_term = 'a pigeon sat on a branch reflecting on existence'

    mock_piratebay
    mock_kickass
    mock_isohunt
    mock_extratorrent

    result = Torrentify.search_all_return_best(search_term)

    result.each do |item|
      puts item
    end
    assert_not_nil result
    assert_false result.empty?
  end

  def mock_piratebay
    file_path = 'sites/test_data/piratebay_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'https://thepiratebay.mn/search/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end

  def mock_kickass
    file_path = 'sites/test_data/kickass_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end

  def mock_isohunt
    file_path = 'sites/test_data/isohunt_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'https://isohunt.to/torrents/?ihq=a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end

  def mock_extratorrent
    file_path = 'sites/test_data/extratorrent_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'http://extratorrent.cc/search/?search=a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end
end

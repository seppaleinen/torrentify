#!/usr/bin/ruby
require_relative '../test_helper'

require_relative '../../lib/model/torrent_model'

# Tests for kickass
class TestTorrentModelClass < Test::Unit::TestCase
  def test_model_to_s
    torrent = Torrent.new('torrent_file', 'name', 'size', 'seeders', 'leechers')

    assert_not_nil torrent

    actual = capture_stdout do
      puts torrent
    end.string

    expected = capture_stdout do
      puts "torrent_file: torrent_file\n"
      puts "name: name\n"
      puts "size: size\n"
      puts "seeders: seeders\n"
      puts "leechers: leechers\n"
    end.string

    assert_equal expected, actual
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

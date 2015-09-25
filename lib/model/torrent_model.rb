#!/usr/bin/ruby

# Model for saving torrent info
class Torrent
  def initialize(torrent_file, name, size, seeders, leechers)
    @torrent_file = torrent_file
    @name = name
    @size = size
    @seeders = seeders
    @leechers = leechers
  end

  def to_s
    s = StringIO.open do |s|
      s.puts 'torrent_file: ' + torrent_file.to_s
      s.puts 'name: ' + name.to_s
      s.puts 'size: ' + size.to_s
      s.puts 'seeders: ' + seeders.to_s
      s.puts 'leechers: ' + leechers.to_s
      s.string
    end
    return s
  end

  attr_reader :torrent_file
  attr_reader :name
  attr_reader :size
  attr_reader :seeders
  attr_reader :leechers
end

#!/usr/bin/ruby

# Model for saving torrent info
class Torrent
  # Fast init for class
  def initialize(torrent_file, name, size, seeders, leechers)
    @torrent_file = torrent_file
    @name = name
    @size = size
    @seeders = seeders
    @leechers = leechers
  end

  # Overrides to_s method
  def to_s
    string = StringIO.open do |s|
      s.puts 'torrent_file: ' + @torrent_file.to_s
      s.puts 'name: ' + @name.to_s
      s.puts 'size: ' + @size.to_s
      s.puts 'seeders: ' + @seeders.to_s
      s.puts 'leechers: ' + @leechers.to_s
      s.string
    end
    string
  end

  # Accessor for torrent url
  attr_reader :torrent_file
  # Accessor for torrent name
  attr_reader :name
  # Accessor for torrent size
  attr_reader :size
  # Accessor for torrent seeders
  attr_reader :seeders
  # Accessor for torrent leechers
  attr_reader :leechers
end

#!/usr/bin/ruby

# Model for saving torrent info
class Torrent
  attr_accessor :torrent_file
  attr_accessor :name
  attr_accessor :size
  attr_accessor :seeders
  attr_accessor :leechers
end

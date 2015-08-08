#!/usr/bin/ruby

# Class responsible for parsing
# the page response from kickass
class KickassParser
  def initialize(page)
    @page = page
  end

  get_list_of_torrents
    @page.link_with(:href => 'http://torcache.net/torrent')
  end  
end
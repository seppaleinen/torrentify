#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from imdb
class ImdbParser
  # Init method. Takes mechanize page as parameter
  def initialize(page)
    @page = page
  end

  # Parses values from rss-feed
  module Parser
    BASEURL = 'http://rss.imdb.com'

    # Extracts title-name
    def self.title(div)
      div.search('.//title')[0].content
    end
  end

  # Main method of class
  # Makes a list of all the torrent on a page
  # and loops through them, extracting information from Parser.
  # Returns a list of torrent-objects
  def main_divs
    items = @page.search('.//item')
    titles = []
    items.each do |item|
      title = Parser.title(item)
      titles.push(title)
    end
    titles
  end
end

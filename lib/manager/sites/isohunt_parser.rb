#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from isohunt
class IsohuntParser
  # Takes mechanize page
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    BASEURL = 'https://isohunt.to'

    # Extracts amount of leechers on torrent
    def self.seeders(div)
      links = div.search(".//td[@class=' sy' or @class=' sn']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    # Hardcodes amount of leechers to N/A
    def self.leechers(_div)
      'N/A'
    end

    # Extracts size on torrent
    def self.size(div)
      links = div.search(".//td[@class='size-row']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    # Extracts torrent url
    def self.torrent_url(div)
      links = div.search('.//a[@href]')
      BASEURL + links[0].attributes['href']
    end

    # Extracts torrent name
    def self.torrent_name(div)
      links = div.search('.//a[@href]')
      links[0].content
    end
  end

  # Main method of class
  # Makes a list of all the torrent on a page
  # and loops through them, extracting information from Parser.
  # Returns a list of torrent-objects
  def main_divs
    divs = @page.search('.//tr[@data-key]')
    torrents = []
    divs.each do |div|
      torrent_file = Parser.torrent_url(div)
      name = Parser.torrent_name(div)
      size = Parser.size(div)
      seeders = Parser.seeders(div)
      leechers = Parser.leechers(div)
      torrent = Torrent.new(torrent_file, name, size, seeders, leechers)
      torrents.push(torrent)
    end
    torrents
  end
end

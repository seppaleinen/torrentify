#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from kickass
class PirateBayParser
  # Takes mechanize page
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    BASEURL = 'https://thepiratebay.mn'

    # Extracts amount of leechers on torrent
    def self.seeders(div)
      links = div.search(".//td[@align='right']")
      links[0].content if !links.nil? && !links[0].nil?
    end

    # Extracts amount of leechers on torrent
    def self.leechers(div)
      links = div.search(".//td[@align='right']")
      links[1].content if !links.nil? && !links[1].nil?
    end

    # Extracts size on torrent
    def self.size(div)
      links = div.search(".//font[@class='detDesc']")
      value = ''
      links.each do |link|
        value = link.content[/#{'Size '}(.*?)#{', '}/m, 1]
      end
      value
    end

    # Extracts torrent url
    def self.torrent_url(div)
      links = div.search(".//a[@title='Download this torrent using magnet']")
      value = ''
      links.each do |link|
        value = link.attributes['href']
      end
      BASEURL + value
    end

    # Extracts torrent name
    def self.torrent_name(div)
      links = div.search(".//a[@class='detLink']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end
  end

  # Main method of class
  # Makes a list of all the torrent on a page
  # and loops through them, extracting information from Parser.
  # Returns a list of torrent-objects
  def main_divs
    divs = @page.search('.//tr')
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

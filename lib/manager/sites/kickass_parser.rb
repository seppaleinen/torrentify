#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from kickass
class KickassParser
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    BASEURL = 'https://kat.cr'

    def self.seeders(div)
      links = div.search(".//td[@class='red lasttd center']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.leechers(div)
      links = div.search(".//td[@class='green center']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.size(div)
      links = div.search(".//td[@class='nobr center']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.torrent_url(div)
      links = div.search(".//a[@title='Download torrent file']")
      value = ''
      links.each do |link|
        value = link.attributes['href']
      end
      value
    end

    def self.torrent_name(div)
      links = div.search(".//a[@class='cellMainLink']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end
  end

  def main_divs
    divs = @page.search(".//tr[@class='even' or @class='odd']")
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

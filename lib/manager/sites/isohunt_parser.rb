#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from isohunt
class IsohuntParser
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    def self.seeders(div)
      links = div.search(".//td[@class=' sy' or @class=' sn']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.leechers(_div)
      'N/A'
    end

    def self.size(div)
      links = div.search(".//td[@class='size-row']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.torrent_url(div)
      links = div.search('.//a[@href]')
      links[0].attributes['href']
    end

    def self.torrent_name(div)
      links = div.search('.//a[@href]')
      links[0].content
    end
  end

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

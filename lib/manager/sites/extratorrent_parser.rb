#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from kickass
class ExtratorrentParser
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    BASEURL = 'http://extratorrent.cc'

    def self.seeders(div)
      links = div.search(".//td[@class='sy']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.leechers(div)
      links = div.search(".//td[@class='ly']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end

    def self.size(div)
      links = div.search('.//td')
      links[3].content
    end

    def self.torrent_url(div)
      links = div.search('.//a')
      BASEURL + links[0].attributes['href']
    end

    def self.torrent_name(div)
      links = div.search('.//a')
      # Get link title and strip Download och torrent from result
      title = links[0].attributes['title'].text
      title.gsub!('Download ', '').gsub!(' torrent', '')
    end
  end

  def main_divs
    divs = @page.search(".//tr[@class='tlr' or @class='tlz']")
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

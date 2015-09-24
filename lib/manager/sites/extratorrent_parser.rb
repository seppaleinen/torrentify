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
      links[0].attributes['href']
    end

    def self.torrent_name(div)
      links = div.search('.//a')
      links[0].attributes['href']
    end
  end

  def main_divs
    divs = @page.search(".//tr[@class='tlr' or @class='tlz']")
    puts divs
    divs.each do |div|
      puts '-----------------'
      puts Parser.torrent_url(div)
      puts Parser.torrent_name(div)
      puts Parser.size(div)
      puts Parser.seeders(div)
      puts Parser.leechers(div)
    end
    divs
  end
end

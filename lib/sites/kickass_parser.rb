#!/usr/bin/ruby

require 'torrent_model'

# Class responsible for parsing
# the page response from kickass
class KickassParser
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
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

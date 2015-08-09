#!/usr/bin/ruby

# Class responsible for parsing
# the page response from kickass
class KickassParser
  def initialize(page)
    @page = page
  end

  def seeders(div)
    links = div.search(".//td[@class='red lasttd center']")
    value = ''
    links.each do |link|
      value = link.content
    end
    value
  end

  def leechers(div)
    links = div.search(".//td[@class='green center']")
    value = ''
    links.each do |link|
      value = link.content
    end
    value
  end

  def size(div)
    links = div.search(".//td[@class='nobr center']")
    value = ''
    links.each do |link|
      value = link.content
    end
    value
  end

  def torrent_url(div)
    links = div.search(".//a[@title='Download torrent file']")
    value = ''
    links.each do |link|
      value = link.attributes['href']
    end
    value
  end

  def torrent_name(div)
    links = div.search(".//a[@class='cellMainLink']")
    value = ''
    links.each do |link|
      value = link.content
    end
    value
  end

  def main_divs
    divs = @page.search(".//tr[@class='even' or @class='odd']")
    divs.each do |div|
      puts '-----------------'
      puts torrent_url(div)
      puts torrent_name(div)
      puts size(div)
      puts seeders(div)
      puts leechers(div)
    end
    divs
  end
end

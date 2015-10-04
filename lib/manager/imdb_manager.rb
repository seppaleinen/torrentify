#!/usr/bin/ruby
require 'mechanize'

# Class responsible for connecting to imdb
# e.g getting user watchlist
class ImdbManager
  # Module responsible for setting up mechanize-agent
  module Agent
    def self.get_web_page(url)
      agent = Mechanize.new
      # Default File implementation does not work
      agent.pluggable_parser.default = Mechanize::Page
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.get(url)
    end
  end

  def get_watchlist(userid)
    rss_url = 'http://rss.imdb.com/user/userid/watchlist'
    url = rss_url.gsub('userid', userid)
    titles = []
    begin
      page = Agent.get_web_page(url)
      items = page.search('.//item')
      items.each do |item|
        title = item.search('.//title')[0].content
        titles.push(title)
      end
      titles
    rescue
      []
    end
  end
end

#!/usr/bin/ruby
require 'mechanize'
require_relative 'sites/imdb_parser'

# Class responsible for connecting to imdb
# e.g getting user watchlist
class ImdbManager
  # Module responsible for setting up mechanize-agent
  module Agent
    # Agent method responsible for calling url and returning page object
    def self.get_web_page(url)
      agent = Mechanize.new
      # Default File implementation does not work
      agent.pluggable_parser.default = Mechanize::Page
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.get(url)
    end
  end

  # Creates request parameter
  def get_watchlist(userid)
    rss_url = 'http://rss.imdb.com/user/userid/watchlist'
    url = rss_url.gsub('userid', userid)
    begin
      page = Agent.get_web_page(url)
      ImdbParser.new(page).main_divs
    rescue
      []
    end
  end
end

#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'

# Manager responsible for scraping webpage
class MechanizeManager
  def initialize
    @agent = Mechanize.new
  end

  def get_web_page(url)
    @agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @agent.get(url)
  end
end

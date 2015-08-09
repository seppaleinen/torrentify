#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'

# Manager responsible for scraping webpagem
class MechanizeManager
  def initialize
  end

  # Module responsible for calling mechanize
  module Agent
    def self.get_web_page(url)
      agent = Mechanize.new
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.get(url)
    end
  end

  def search_kickass(search_term)
    white_space = '%20'
    url = 'https://kat.cr/usearch/' << search_term.gsub!(' ', white_space)
    Agent.get_web_page(url)
  end
end

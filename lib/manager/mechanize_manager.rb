#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'
require_relative 'sites/kickass_parser'

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
    url = 'https://kat.cr/usearch/' << search_term.gsub(' ', white_space)
    puts "Searching for '#{search_term}' on kickass"
    page = Agent.get_web_page(url)
    KickassParser.new(page).main_divs
    page
  end

  def search_piratebay(search_term)
    white_space = '%20'
    pirate_url = 'https://thepiratebay.mn/search/'
    url = pirate_url << search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    PirateBayParser.new(page).main_divs
    page
  end
end

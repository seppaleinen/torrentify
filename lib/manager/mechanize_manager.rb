#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'
require_relative 'sites/kickass_parser'
require_relative 'sites/piratebay_parser'
require_relative 'sites/isohunt_parser'
require_relative 'sites/extratorrent_parser'

# Manager responsible for scraping webpagem
class MechanizeManager
  def initialize
  end

  # Module responsible for calling mechanize
  module Agent
    def self.get_web_page(url)
      agent = Mechanize.new
      agent.pluggable_parser.default = Mechanize::Page
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
  end

  def search_piratebay(search_term)
    white_space = '%20'
    pirate_url = 'https://thepiratebay.mn/search/'
    url = pirate_url << search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    PirateBayParser.new(page).main_divs
  end

  def search_isohunt(search_term)
    white_space = '%20'
    isohunt_url = 'https://isohunt.to/torrents/?ihq='
    url = isohunt_url << search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    IsohuntParser.new(page).main_divs
  end

  def search_extratorrent(search_term)
    white_space = '+'
    extratorrent_url = 'http://extratorrent.cc/search/?search='
    url = extratorrent_url << search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    ExtratorrentParser.new(page).main_divs
  end
end

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
    baseurl = KickassParser::Parser::BASEURL
    kickass_url = baseurl + '/usearch/'
    url = kickass_url + search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    KickassParser.new(page).main_divs
  end

  def search_piratebay(search_term)
    white_space = '%20'
    baseurl = PirateBayParser::Parser::BASEURL
    pirate_url = baseurl + '/search/'
    url = pirate_url + search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    PirateBayParser.new(page).main_divs
  end

  def search_isohunt(search_term)
    white_space = '%20'
    baseurl = IsohuntParser::Parser::BASEURL
    isohunt_url = baseurl + '/torrents/?ihq='
    url = isohunt_url + search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    IsohuntParser.new(page).main_divs
  end

  def search_extratorrent(search_term)
    white_space = '+'
    baseurl = ExtratorrentParser::Parser::BASEURL
    extratorrent_url = baseurl + '/search/?search='
    url = extratorrent_url + search_term.gsub(' ', white_space)
    page = Agent.get_web_page(url)
    ExtratorrentParser.new(page).main_divs
  end
end

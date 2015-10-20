#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'
require 'typhoeus'
require_relative 'sites/kickass_parser'
require_relative 'sites/piratebay_parser'
require_relative 'sites/isohunt_parser'
require_relative 'sites/extratorrent_parser'

# Manager responsible for scraping webpages
class MechanizeManager
  # Module responsible for calling mechanize
  module Agent
    # Static method responsible for calling url and returning page object
    def self.get_web_page(url)
      agent = Mechanize.new
      agent.pluggable_parser.default = Mechanize::Page
      agent.user_agent = 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4a) Gecko/20030401'
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.get(url)
    end
  end

  # Creates request parameter and passes mechanize-page result
  # to KickassParser.main_divs
  # Takes search_term
  # Returns list of torrents or empty list if error.
  def search_kickass(search_term)
    white_space = '%20'
    baseurl = KickassParser::Parser::BASEURL
    kickass_url = baseurl + '/usearch/'
    url = kickass_url + search_term.gsub(' ', white_space)

    begin
      page = Agent.get_web_page(url)
      KickassParser.new(page).main_divs
    rescue
      []
    end
  end

  # Creates request parameter and passes mechanize-page result
  # to PirateBayParser.main_divs
  # Takes search_term
  # Returns list of torrents or empty list if error.
  def search_piratebay(search_term)
    white_space = '%20'
    baseurl = PirateBayParser::Parser::BASEURL
    pirate_url = baseurl + '/search/'
    url = pirate_url + search_term.gsub(' ', white_space)

    begin
      page = Agent.get_web_page(url)
      PirateBayParser.new(page).main_divs
    rescue
      []
    end
  end

  # Creates request parameter and passes mechanize-page result
  # to IsohuntParser.main_divs
  # Takes search_term
  # Returns list of torrents or empty list if error.
  def search_isohunt(search_term)
    white_space = '%20'
    baseurl = IsohuntParser::Parser::BASEURL
    isohunt_url = baseurl + '/torrents/?ihq='
    url = isohunt_url + search_term.gsub(' ', white_space)

    begin
      page = Agent.get_web_page(url)
      IsohuntParser.new(page).main_divs
    rescue
      []
    end
  end

  # Creates request parameter and passes mechanize-page result
  # to ExtratorrentParser.main_divs
  # Takes search_term
  # Returns list of torrents or empty list if error.
  def search_extratorrent(search_term)
    white_space = '+'
    baseurl = ExtratorrentParser::Parser::BASEURL
    extratorrent_url = baseurl + '/search/?search='
    url = extratorrent_url + search_term.gsub(' ', white_space)

    begin
      page = Agent.get_web_page(url)
      ExtratorrentParser.new(page).main_divs
    rescue
      []
    end
  end
end

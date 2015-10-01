#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'
require 'typhoeus'
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
      agent.user_agent = 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4a) Gecko/20030401'
      agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.get(url)
    end
  end

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

  def search_extratorrent(search_term)
    white_space = '+'
    baseurl = ExtratorrentParser::Parser::BASEURL
    extratorrent_url = baseurl + '/search/?search='
    url = extratorrent_url + search_term.gsub(' ', white_space)

    # result = extra_torrent_cloudflare_ddos_breaker(url)
    begin
      page = Agent.get_web_page(url)
      ExtratorrentParser.new(page).main_divs
    rescue
      []
    end
  end

  def extra_torrent_cloudflare_ddos_breaker(url)
    response = Typhoeus::Request.get(url, :cookiefile => '.typhoeus_cookies', :cookiejar => '.typhoeus_cookies')
    body = response.response_body
    challenge = body.match(%r{name="jschl_vc"\s*value="([a-zA-Z0-9]+)"/\>}).captures[0]
    math = body.match(/a\.value\s*=\s*(.+?\d?);/).captures[0]
    domain = url.split('/')[2]
    answer = eval(math) + domain.length
    asd = '/cdn-cgi/l/chk_jschl?jschl_vc='
    answer_url = domain + asd + "#{challenge}&jschl_answer=#{answer}"
    puts answer_url
    html = Typhoeus.get(answer_url, :followlocation => true)
    body = html.response_body
    puts 'body' + body
  end
end

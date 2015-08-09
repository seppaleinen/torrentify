#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'

def get_web_page(url)
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  agent.get(url)
end

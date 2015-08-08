#!/usr/bin/ruby
require 'rubygems'
require 'mechanize'

def get_web_page(url)
  agent = Mechanize.new
  agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  agent.get(url)
end

def pretty_print_page(page)
  pp page
end

def get_links(links)
  links.each do |link|
    puts link.text
  end
end

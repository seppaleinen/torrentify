#!/usr/bin/ruby

require_relative 'manager/mechanize_manager'
require_relative 'manager/imdb_manager'

# Main interface
# Responsible for running manager-methods
module Torrentify
  def self.search(search_param)
    MechanizeManager.new.search_kickass(search_param)
  end

  def self.imdb_watchlist(userid)
    ImdbManager.new.get_watchlist(userid)
  end
end

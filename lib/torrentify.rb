#!/usr/bin/ruby

require_relative 'manager/mechanize_manager'
require_relative 'manager/imdb_manager'

# Main interface
# Responsible for running manager-methods
module Torrentify
  def self.search(search_param)
    manager = MechanizeManager.new
    kickass = manager.search_kickass(search_param)
    piratebay = manager.search_piratebay(search_param)
    isohunt = manager.search_isohunt(search_param)
    # extratorrent = manager.search_extratorrent(search_param)
    [kickass, piratebay, isohunt]
  end

  def self.imdb_watchlist(userid)
    ImdbManager.new.get_watchlist(userid)
  end
end

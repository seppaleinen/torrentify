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
    extratorrent = manager.search_extratorrent(search_param)
    [kickass, piratebay, isohunt, extratorrent]
  end

  def self.search_all_return_best(search_param)
    manager = MechanizeManager.new
    kickass = manager.search_kickass(search_param)
    piratebay = manager.search_piratebay(search_param)
    isohunt = manager.search_isohunt(search_param)
    extratorrent = manager.search_extratorrent(search_param)

    kickass = __sort_result__(kickass)
    piratebay = __sort_result__(piratebay)
    isohunt = __sort_result__(isohunt)
    extratorrent = __sort_result__(extratorrent)

    [kickass.last, piratebay.last, isohunt.last, extratorrent.last]
  end

  def self.__sort_result__(result)
    result.sort_by { |e| [e.seeders.to_i, e.leechers.to_i] }
  end

  def self.imdb_watchlist(userid)
    ImdbManager.new.get_watchlist(userid)
  end
end

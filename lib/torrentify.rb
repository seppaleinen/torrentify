#!/usr/bin/ruby

require_relative 'manager/mechanize_manager'
require_relative 'manager/imdb_manager'

# Main interface
# Responsible for running manager-methods
module Torrentify
  # Static method for searching torrent-sites
  # Takes string parameter search_param
  # And string parameter search_engine which defines which sites
  # to search and defaults to ALL
  def self.search(search_param, search_engine = 'ALL')
    manager = MechanizeManager.new
    kickass = []
    piratebay = []
    isohunt = []
    extratorrent = []
    case "#{search_engine}"
    when 'KICKASS'
      kickass = manager.search_kickass(search_param)
    when 'PIRATEBAY'
      piratebay = manager.search_piratebay(search_param)
    when 'ISOHUNT'
      isohunt = manager.search_isohunt(search_param)
    when 'PIRATEBAY'
      extratorrent = manager.search_extratorrent(search_param)
    when 'ALL'
      kickass = manager.search_kickass(search_param)
      piratebay = manager.search_piratebay(search_param)
      isohunt = manager.search_isohunt(search_param)
      extratorrent = manager.search_extratorrent(search_param)
    else
      fail 'not valid search_engine'
    end
    [kickass, piratebay, isohunt, extratorrent]
  end

  # Static method for searching through all sites and returning
  # the best from each of them.
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

  # Static private method responsible for sorting torrent-file
  def self.__sort_result__(result)
    result.sort_by { |e| [e.seeders.to_i, e.leechers.to_i] }
  end

  # Static method for getting imdb watch-list results
  def self.imdb_watchlist(userid)
    ImdbManager.new.get_watchlist(userid)
  end
end

#!/usr/bin/ruby

require_relative 'manager/mechanize_manager'

# Main interface
# Responsible for running manager-methods
module Torrentify
  def self.search(search_param)
    MechanizeManager.new.search_kickass(search_param)
  end
end

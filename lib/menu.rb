#!/usr/bin/ruby

require_relative 'mechanize_manager.rb'

# Class responsible for client-interface
class Menu
  # Prints available commands
  def self.run
    puts 'Enter search criteria'
    choice = gets.chomp
    MechanizeManager.new.search_kickass(choice)
    choice
  end

  def self.choose(choice)
    case choice
    when '1' then puts '1'
    when '2' then puts '2'
    else
      puts 'other'
    end
  end
end

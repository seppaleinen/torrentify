#!/usr/bin/ruby

require_relative 'code.rb'

# Class responsible for client-interface
class Menu
  # Prints available commands
  def self.run
    puts 'Enter search criteria'
    gets.chomp
  end
end

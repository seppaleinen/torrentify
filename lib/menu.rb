#!/usr/bin/ruby

require_relative 'code.rb'

class Menu
  #Prints available commands
  def self.run
    puts "Enter search criteria"
    value = gets.chomp
    puts "#{value}"
  end
end
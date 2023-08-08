require_relative 'item'
require_relative 'game'
require_relative 'author'

class App
  def initialize
    @games = []
    @authors = []
  end

  def list_of_games
    puts ''.center(50, '*')
    puts 'The list is empty, please create a game!' if @games.empty?
    @games.each { |ele| puts "Title: #{ele.multiplayer}, Author: #{ele.last_played_at}" }
  end

  def list_all_authors
    puts ''.center(50, '*')
    puts 'The list is empty, please create a author!' if @authors.empty?
    @authors.each { |ele| puts "First Name: #{ele.first_name}, Last Name: #{ele.last_name}" }
  end

  def exit_program
    puts 'Exiting the program...'
    exit
  end
end

require_relative 'item'
require_relative 'game'

class App
  def initialize
    @games = []
  end

  def list_of_games
    puts ''.center(50, '*')
    puts 'The list is empty, please create a game!' if @games.empty?
    @games.each { |ele| puts "Title: #{ele.multiplayer}, Author: #{ele.last_played_at}" }
  end

  def exit_program
    puts 'Exiting the program...'
    exit
  end
end

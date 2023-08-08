require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'save_data'
require_relative 'load_data'

class App
  def initialize
    @games = load_games
    @authors = []
  end

  def list_of_games
    puts ''.center(50, '*')
    puts 'The list is empty, please create a game!' if @games.empty?
    @games.each { |ele| puts "Multiplayer: #{ele.multiplayer}, Last played at: #{ele.last_played_at}" }
  end

  def list_all_authors
    puts ''.center(50, '*')
    puts 'The list is empty, please create a author!' if @authors.empty?
    @authors.each { |ele| puts "First Name: #{ele.first_name}, Last Name: #{ele.last_name}" }
  end

  def add_game
    puts 'Add a game'
    print 'Multiplayer: '
    player = gets.chomp.capitalize
    print "Please enter a date Last played at 'YYYY-MM-DD': "
    input = gets.chomp.strip
    game = Game.new(player, input)
    @games << game
    puts 'Successfully created a game!'
    puts
  end

  def exit_program
    save_games
    puts 'Exiting the program...'
    exit
  end
end

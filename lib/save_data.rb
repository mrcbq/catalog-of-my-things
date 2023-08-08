require 'json'
require_relative 'game'

def save_games
  games_arr = []
  @games.each { |game| games_arr.push({ multiplayer: game.multiplayer, last_played_at: game.last_played_at }) }
  File.write('games.json', games_arr.to_json) if @games.any?
  puts 'Saving games to database...'
end

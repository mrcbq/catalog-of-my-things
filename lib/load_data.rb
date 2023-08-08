require_relative 'game'
require 'json'

def load_games
  stored_games = begin
    JSON.parse(File.read('games.json'))
  rescue StandardError => e
    puts "Error reading 'rental.json': #{e.message}"
    []
  end
  games = []
  stored_games.map do |game_data|
    games << Game.new(game_data['multiplayer'], game_data['last_played_at'])
  end
  games
end




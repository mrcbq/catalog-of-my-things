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

def load_authors
  stored_authors = begin
    JSON.parse(File.read('authors.json'))
  rescue StandardError => e
    puts "Error reading 'authors.json': #{e.message}"
    []
  end
  authors = []
  stored_authors.map do |author_data|
    authors << Author.new(author_data['first_name'], author_data['last_name'])
  end
  authors
end

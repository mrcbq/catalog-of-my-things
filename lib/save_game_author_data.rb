require 'json'
require_relative 'game'
require_relative 'author'

def save_games
  games_arr = []
  @games.each { |game| games_arr.push({ multiplayer: game.multiplayer, last_played_at: game.last_played_at }) }
  File.write('games.json', games_arr.to_json) if @games.any?
  puts 'Saving games to database...'
end

def save_authors
  authors_arr = []
  @authors.each do |author|
    authors_arr.push({ id: author.id, first_name: author.first_name, last_name: author.last_name })
  end
  File.write('authors.json', authors_arr.to_json) if @authors.any?
  puts 'Saving authors to database...'
end

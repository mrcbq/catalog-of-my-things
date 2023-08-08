require_relative 'music_album'
require_relative 'genre'
require 'json'

def load_music_albums
  stored_music_albums = begin
    JSON.parse(File.read('music_albums.json'))
  rescue StandardError => e
    puts "Error reading 'music_albums.json': #{e.message}"
    []
  end
  music_albums = []
  stored_music_albums.map do |music_album|
    music_albums << Game.new(music_album['published_date'], music_album['on_spotify'])
  end
  music_albums
end

def load_genre
  stored_genre = begin
    JSON.parse(File.read('genre.json'))
  rescue StandardError => e
    puts "Error reading 'genre.json': #{e.message}"
    []
  end
  genre = []
  stored_genre.map do |genre|
    genre << Genre.new(genre['name'])
  end
  genre
end

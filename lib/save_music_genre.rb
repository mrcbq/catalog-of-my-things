require 'json'
require_relative 'music_album'
require_relative 'genre'

def save_music_albums
  music_albums_arr = []
  @music_albums.each { |music_album| music_albums_arr.push({ published_date: music_album.published_date, on_spotify: music_album.on_spotify }) }
  File.write('music_albums.json', music_albums_arr.to_json) if @music_albums.any?
  puts 'Saving music_albums to database...'
end

def save_genres
  genres_arr = []
  @genres.each do |genre|
    genres_arr.push({ name: genre.name })
  end
  File.write('genres.json', genres_arr.to_json) if @genres.any?
  puts 'Saving genres to database...'
end

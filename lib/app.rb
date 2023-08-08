require_relative 'item'
require_relative 'genre'
require_relative 'music_album'
require 'date'

class App
  attr_accessor :music_albums, :genres

  def initialize
    @music_albums = []
    @genres = []
  end

  def exit_program
    puts 'Exiting the program...'
    exit
  end

  def list_all_genres(genres)
    genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_all_music_albums(items)
    puts 'List of all music albums:'
    items.each_with_index do |item, index|
      next unless item.is_a?(MusicAlbum)

      puts "#{index + 1}. #{item.title} (Published: #{item.published_date}, Archived: #{item.archived})"
    end
  end

  def add_music_album(items)
    print 'Enter published date YYYY-MM-DD: '
    date_input = gets.chomp
    begin
      published_date = Date.parse(date_input)
      current_date = Date.today
      difference = (current_date - published_date).to_i

      puts "The album was publised #{difference} days ago"
    rescue ArgumentError
      puts 'invalid date format. Please enter the date in YYYY-MM-DD format'
    end

    print 'Is it on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    music_album = MusicAlbum.new(published_date: published_date, on_spotify: on_spotify)
    items << music_album

    puts 'Music album added successfully!'
  end
end

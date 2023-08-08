require_relative 'item'

require_relative 'genre'
require_relative 'music_album'
require 'date'

class App
  attr_accessor :music_albums, :genres

  require_relative 'label'
  require 'date'

  class App
    attr_accessor :music_albums, :genres, :labels

    def initialize
      @music_albums = []
      @genres = []
      @labels = []
    end

    def exit_program
      puts 'Exiting the program...'
      exit
    end

    def list_all_genres()
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}. #{genre.name}"
      end
    end

    def list_all_labels
      Label.list_all_labels(@labels)
    end

    def list_all_music_albums()
      puts 'List of all music albums:'
      @music_albums.each_with_index do |album, index|
        next unless album.is_a?(MusicAlbum)

        puts "#{index + 1}. #(Published: #{album.published_date}, Archived: #{album.archived?})"
      end
    end

    def add_music_album()
      print 'Enter published date YYYY-MM-DD: '
      date_input = gets.chomp
      begin
        published_date = Date.parse(date_input)
        current_date = Date.today
        difference = (current_date - published_date).to_i / 365

        puts "The album was published #{difference} years ago"
      rescue ArgumentError
        puts 'invalid date format. Please enter the date in YYYY-MM-DD format'
      end

      print 'Is it on Spotify? (true/false): '
      on_spotify = gets.chomp.downcase == 'true'

      music_album = MusicAlbum.new(published_date: published_date, on_spotify: on_spotify)
      music_albums << music_album

      puts 'Music album added successfully!'
    end
  end
end

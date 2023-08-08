require_relative 'item'
require_relative 'game'
require_relative 'author'
require_relative 'book'
require_relative 'label'
require_relative 'music_album'
require_relative 'genre'
require 'date'
require_relative 'save_game_author_data'
require_relative 'load_game_author_data'

class App
  attr_accessor :music_albums, :genres, :books, :labels

  def initialize
    @music_albums = []
    @genres = []
    @books = []
    @labels = []
    @games = load_games
    @authors = load_authors
  end

  def list_all_genres
    @genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_all_labels
    Label.list_all_labels(@labels)
  end

  def list_all_music_albums
    puts 'List of all music albums:'
    @music_albums.each_with_index do |album, index|
      next unless album.is_a?(MusicAlbum)

      puts "#{index + 1}. #(Published: #{album.published_date}, Archived: #{album.archived?})"
    end
  end

  def add_music_album
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

  def list_all_books
    Book.list_all_books(@books)
  end

  def add_book
    book = Book.new
    book.add_book(@books, @labels)
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
    save_authors
    puts 'Exiting the program...'
    exit
  end
end

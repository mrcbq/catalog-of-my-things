require_relative 'item'
require_relative 'label'

class Book < Item
  attr_accessor :publisher, :cover_state, :label, :genre, :author

  def initialize(options = {})
    super(published_date: options[:published_date])
    @publisher = options[:publisher]
    @id = Random.rand(1..1000)
    @cover_state = options[:cover_state]
    @label = options[:label]
    @genre = options[:genre]
    @author = options[:author]
  end

  def self.list_all_books(books)
    puts 'All Books:'
    books.each do |_book|
      if books.empty?
        puts 'No books added yet'
      else
        books.each do |book|
          puts "Book ID: #{book.instance_variable_get(:@id)}"
          puts "Book Name: #{book.label.title}"
          puts "Author: #{book.author.first_name} #{book.author.last_name}"
          puts "Genre: #{book.genre.name}" if book.genre
          puts "Published by: #{book.publisher} on: #{book.published_date}"
          puts "Color: #{book.label.color}\n"
        end
      end
    end
  end

  def add_book(books, labels, genres, authors)
    title = book_title
    publisher = input_publisher
    cover_state = input_cover_state
    published_date = input_published_date
    label = input_label(labels)
    genre = input_genre(genres)
    author = input_author(authors)

    book = create_book(title, publisher, cover_state, published_date, label, genre, author)
    books << book
    puts 'Book added successfully!'
  end

  def save_books_to_json(filename)
    File.open(filename, 'w') do |file|
      file.puts JSON.dump(@books)
    end
    puts 'Books data saved to JSON.'
  end

  def load_books_from_json(filename)
    if File.exist?(filename)
      @books = JSON.parse(File.read(filename), symbolize_names: true)
      puts 'Books data loaded from JSON.'
    else
      puts 'No JSON data found. Starting with an empty book list.'
    end
  end

  private

  def book_title
    print 'Enter book title: '
    gets.chomp
  end

  def input_publisher
    print 'Enter publisher: '
    gets.chomp
  end

  def input_cover_state
    print 'Enter cover state (good/bad): '
    gets.chomp
  end

  def input_genre(genres)
    print 'Select a genre:'
    genres.each_with_index { |genre, index| puts "#{index + 1}. #{genre.name}" }
    genre_index = gets.chomp.to_i - 1
    genres[genre_index] if (0...genres.length).include?(genre_index)
  end

  def input_author(authors)
    print 'Enter author first name:'
    first_name = gets.chomp
    print 'Enter author last name:'
    last_name = gets.chomp

    author = authors.find { |a| a.first_name == first_name && a.last_name == last_name }
    unless author
      author = Author.new(first_name, last_name)
      authors << author
    end

    author
  end

  def input_published_date
    print 'Enter published date YYYY-MM-DD: '
    date_input = gets.chomp
    Date.parse(date_input)
  rescue ArgumentError
    puts 'Invalid date format. Please enter the date in YYYY-MM-DD format'
    retry
  end

  def input_label(labels)
    print 'Enter label title: '
    label_title = gets.chomp
    print 'Enter label color: '
    color = gets.chomp

    label = Label.new(id: labels.length + 1, title: label_title, color: color)
    labels << label
    label
  end

  def create_book(title, publisher, cover_state, published_date, label, genre, author)
    Book.new(
      title: title,
      publisher: publisher,
      cover_state: cover_state,
      published_date: published_date,
      label: label,
      genre: genre,
      author: author
    )
  end

  attr_reader :id

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

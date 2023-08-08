require_relative 'item'
require_relative 'label'

class Book < Item
  attr_accessor :publisher, :cover_state, :label, :genre, :author, :title

  def initialize(options = {})
    super(published_date: options[:published_date])
    @title = options[:title]
    @publisher = options[:publisher]
    @id = Random.rand(1..1000)
    @cover_state = options[:cover_state]
    @label = options[:label]
    @genre = options[:genre]
    @author = options[:author]
  end

  def self.list_all_books(books)
    puts '-----------All Books-----------'
    if books.empty?
      puts 'No books added yet'
    else
      books.each do |book|
        puts "Book ID: #{book.instance_variable_get(:@id)}"
        puts "Book Name: #{book.title}"
        puts "Author: #{book.author.first_name} #{book.author.last_name}"
        puts "Genre: #{book.genre}"
        puts "Published by: #{book.publisher} on: #{book.published_date}"
        puts "Color: #{book.label.color}\n"
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
    genre&.name
    author = input_author(authors)

    book = create_book(
      title: title,
      publisher: publisher,
      cover_state: cover_state,
      published_date: published_date,
      label: label,
      genre: genre,
      author: author
    )
    books << book
    puts 'Book added successfully!'
  end

  def self.save_all_books(books)
    books_data = books.map do |book|
      {
        title: book.title,
        publisher: book.publisher,
        cover_state: book.cover_state,
        published_date: book.published_date.to_s,
        label_title: book.label.title,
        label_color: book.label.color,
        genre_name: book.genre,
        author_first_name: book.author.first_name,
        author_last_name: book.author.last_name
      }
    end

    File.write('books.json', JSON.pretty_generate(books_data))

    puts 'Books data saved to books.json'
  end

  def self.load_all_books
    return [] unless File.exist?('books.json')

    authors = {}
    books_data = JSON.parse(File.read('books.json'))

    books_data.map do |book_data|
      author_full_name = "#{book_data['author_first_name']} #{book_data['author_last_name']}"
      author = authors.fetch(author_full_name) do
        authors[author_full_name] = Author.new(book_data['author_first_name'], book_data['author_last_name'])
      end

      label = Label.new(id: 1, title: book_data['label_title'], color: book_data['label_color'])
      genre = Genre.new(name: book_data['genre_name'])

      Book.new(
        title: book_data['title'],
        publisher: book_data['publisher'],
        cover_state: book_data['cover_state'],
        published_date: Date.parse(book_data['published_date']),
        label: label,
        genre: genre,
        author: author
      )
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

  def create_book(options)
    Book.new(
      title: options[:title],
      publisher: options[:publisher],
      cover_state: options[:cover_state],
      published_date: options[:published_date],
      label: options[:label],
      genre: options[:genre],
      author: options[:author]
    )
  end

  attr_reader :id

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

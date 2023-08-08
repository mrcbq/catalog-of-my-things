require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(options = {})
    super(options[:genre], options[:author], options[:source], options[:label], options[:published_date])
    @publisher = options[:publisher]
    @cover_state = options[:cover_state]
  end

  def self.list_all_books(books)
    puts 'All Books:'
    books.each do |_book|
      if books.empty?
        puts 'No books added yet'
      else
        books.each do |book|
          puts "Book ID: #{book.id}"
          # puts "Book Name: #{book.label.title}"
          # puts "Author: #{book.author.first_name} #{book.author.last_name}"
          puts "Published by: #{book.publisher} on: #{book.publish_date}"
          # puts "Genre: #{book.genre.name}"
          puts "Color: #{book.label.color}/n"
        end
      end
    end
  end

  def self.add_book
    print 'Enter book title: '
    gets.chomp

    print 'Enter publisher: '
    publisher = gets.chomp

    print 'Enter cover state (good/bad): '
    cover_state = gets.chomp

    print 'Enter published date YYYY-MM-DD: '
    date_input = gets.chomp
    begin
      published_date = Date.parse(date_input)
    rescue ArgumentError
      puts 'Invalid date format. Please enter the date in YYYY-MM-DD format'
      return
    end

    new_book = Book.new(
      publisher: publisher,
      cover_state: cover_state,
      published_date: published_date
    )

    @books << new_book

    puts 'Book added successfully!'
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

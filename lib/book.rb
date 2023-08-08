require_relative 'item'
require_relative 'label'

class Book < Item
  attr_accessor :publisher, :cover_state, :label

  def initialize(options = {})
    super(published_date: options[:published_date])
    @publisher = options[:publisher]
    @id = Random.rand(1..1000)
    @cover_state = options[:cover_state]
    @label = options[:label]
  end

  def self.list_all_books(books)
    puts 'All Books:'
    books.each do |_book|
      if books.empty?
        puts 'No books added yet'
      else
        books.each do |book|
          puts "Book ID: #{book.instance_variable_get(:@id)}"
          # puts "Book Name: #{book.label.title}"
          # puts "Author: #{book.author.first_name} #{book.author.last_name}"
          puts "Published by: #{book.publisher} on: #{book.published_date}"
          puts "Color: #{book.label.color}\n"
        end
      end
    end
  end

  def add_book(books, labels)
    print 'Enter book title: '
    title = gets.chomp

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

    print 'Enter label title: '
    label_title = gets.chomp
    print 'Enter label color: '
    color = gets.chomp

    label = Label.new(id: labels.length + 1, title: label_title, color: color)
    labels << label

    book = Book.new(
      title: title,
      publisher: publisher,
      cover_state: cover_state,
      published_date: published_date,
      label: label
    )

    books << book
    puts 'Book added successfully!'
  end

  private

  attr_reader :id

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

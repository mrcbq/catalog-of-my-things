require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(options = {})
    super(options[:genre], options[:author], options[:source], options[:label], options[:published_date])
    @publisher = options[:publisher]
    @cover_state = options[:cover_state]
  end

  def self.list_all_books(books)
    puts "All Books:"
    books.each do |book|
      if books.empty?
        puts 'No books added yet'
      else
        books.each do |book|
          puts "Book ID: #{book.id}"
          puts "Book Name: #{book.label.title}"
          puts "Author: #{book.author.first_name} #{book.author.last_name}"
          puts "Published by: #{book.publisher} on: #{book.publish_date}"
          puts "Genre: #{book.genre.name}"
          puts "Color: #{book.label.color}/n"
        end
      end
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

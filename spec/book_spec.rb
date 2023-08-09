require_relative '../lib/book'
require_relative '../lib/author'
require_relative '../lib/genre'
require_relative '../lib/item'
require 'rspec'
require 'date'
require 'json'

RSpec.describe Book do
  let(:dummy_author) { instance_double(Author, first_name: 'John', last_name: 'Doe') }
  let(:dummy_label) { instance_double(Label, title: 'Mystery', color: 'blue') }
  let(:dummy_genre) { instance_double(Genre, name: 'Mystery') }

  describe '.list_all_books' do
    it 'lists all books' do
      book = Book.new(
        title: 'Sample Book',
        publisher: 'Publisher X',
        cover_state: 'good',
        published_date: Date.new(2023, 8, 9),
        label: dummy_label,
        genre: dummy_genre,
        author: dummy_author
      )

      books = [book]
      expect do
        Book.list_all_books(books)
      end.to output(/Book Name: #{book.title}\nAuthor: #{dummy_author.first_name} #{dummy_author.last_name}/).to_stdout
    end

    it 'prints a message for empty book list' do
      books = []
      expect do
        Book.list_all_books(books)
      end.to output(/No books added yet/).to_stdout
    end
  end

  describe '#add_book' do
    it 'adds a new book to the list' do
      labels = [dummy_label]
      authors = [dummy_author]
      allow_any_instance_of(Kernel).to receive(:gets).and_return('Test Book', 'Test Publisher', 'good', '2023-08-09',
                                                                 'Test Label', 'Test Genre', 'John', 'Doe')

      books = []
      book = Book.new
      book.add_book(books, labels, [], authors)

      expect(books.size).to eq(1)
      expect(books[0].title).to eq('Test Book')
    end
  end

  describe '.save_all_books' do
    it 'saves books data to a file' do
      book = Book.new(
        title: 'Sample Book',
        publisher: 'Publisher X',
        cover_state: 'good',
        published_date: Date.new(2023, 8, 9),
        label: dummy_label,
        genre: dummy_genre,
        author: dummy_author
      )

      allow(File).to receive(:write)
      books = [book]
      Book.save_all_books(books)

      expected_data = [
        {
          title: 'Sample Book',
          publisher: 'Publisher X',
          cover_state: 'good',
          published_date: '2023-08-09',
          label_title: 'Mystery',
          label_color: 'blue',
          genre_name: 'Mystery',
          author_first_name: 'John',
          author_last_name: 'Doe'
        }
      ]

      expect(File).to have_received(:write).with('books.json', JSON.pretty_generate(expected_data))
    end
  end

  describe '.load_all_books' do
    it 'loads books from a file' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(
        JSON.generate(
          [
            {
              title: 'Sample Book',
              publisher: 'Publisher X',
              cover_state: 'good',
              published_date: '2023-08-09',
              label_title: 'Mystery',
              label_color: 'blue',
              genre_name: 'Mystery',
              author_first_name: 'John',
              author_last_name: 'Doe'
            }
          ]
        )
      )

      loaded_books = Book.load_all_books
      expect(loaded_books.size).to eq(1)
      loaded_book = loaded_books.first

      expect(loaded_book.title).to eq('Sample Book')
      expect(loaded_book.publisher).to eq('Publisher X')
      expect(loaded_book.cover_state).to eq('good')
      expect(loaded_book.published_date).to eq(Date.new(2023, 8, 9))
      expect(loaded_book.label.title).to eq(dummy_label.title)
      expect(loaded_book.label.color).to eq(dummy_label.color)
      expect(loaded_book.genre.name).to eq(dummy_genre.name)
      expect(loaded_book.author.first_name).to eq(dummy_author.first_name)
      expect(loaded_book.author.last_name).to eq(dummy_author.last_name)
    end

    it 'returns an empty array if the file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      loaded_books = Book.load_all_books
      expect(loaded_books).to be_empty
    end
  end
end

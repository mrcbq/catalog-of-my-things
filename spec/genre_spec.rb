require_relative '../lib/genre'
require_relative '../lib/item'
require 'date'

RSpec.describe Genre do
  describe '#initialize' do
    it 'creates a genre with the given name' do
      genre = Genre.new('Science Fiction')
      expect(genre.name).to eq('Science Fiction')
    end
  end

  describe '#add_item' do
    it 'adds a new item to the genre' do
      genre = Genre.new('Mystery')
      item = Item.new(published_date: Date.new(2020, 1, 1))
      items = genre.add_item(item)
      expect(items).to include(item)
    end
  end
end

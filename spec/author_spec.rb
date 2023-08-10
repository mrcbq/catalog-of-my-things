require_relative '../lib/author'
require_relative '../lib/item'
require 'spec_helper'

RSpec.describe Author do
  describe '#initialize' do
    it 'should be a author' do
      author = Author.new('Mario', 'Puzo')
      expect(author).to be_a Author
    end
  end
  describe '#attributes' do
    it 'return the first_name' do
      author = Author.new('Mario', 'Puzo')
      expect(author.first_name).to eq('Mario')
    end
    it 'return the last_name' do
      author = Author.new('Mario', 'Puzo')
      expect(author.last_name).to eq('Puzo')
    end
  end
  describe '#add_item' do
    it 'should add an item' do
      author = Author.new('Mario', 'Puzo')
      item = Item.new(published_date: '2002-12-12')
      items = author.add_item(item)
      expect(items).to include(item)
    end
  end
end

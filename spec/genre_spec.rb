require_relative '../lib/genre'
require_relative '../lib/item'

RSpec.describe Genre do
  describe '#initialize' do
    it 'creates a genre with the given name' do
      genre = Genre.new('Science Fiction')
      expect(genre.name).to eq('Science Fiction')
    end
  end

end
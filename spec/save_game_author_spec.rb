require_relative '../lib/save_game_author_data'
require 'spec_helper'

RSpec.describe 'save' do
  describe '#should save game' do
    it 'saves the game' do
      game = Game.new('mario', '2002-12-12')
      expect(game.last_played_at).to eq('2002-12-12')
      expect(game.multiplayer).to eq('mario')
    end
  end
end

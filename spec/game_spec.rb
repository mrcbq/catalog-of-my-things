require_relative '../lib/game'
require 'spec_helper'

RSpec.describe Game do
  describe '#initialize' do
    it 'should be a game' do
      game = Game.new('Mario', Time.now)
      expect(game).to be_a Game
    end
  end
  describe '#attributes' do
    it 'return the name' do
      game = Game.new('Mario', Time.now)
      expect(game.multiplayer).to eq('Mario')
    end
    it 'return the last_played_at' do
      game = Game.new('Mario', Time.now)
      expect(game.last_played_at).to be_a(Time)
    end
  end
end

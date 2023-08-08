require_relative '../lib/load_game_author_data'
require 'spec_helper'

RSpec.describe '#load_game_author' do
  it 'loads the game data' do
    game = Game.new('mario', '2002-12-12')
    expect(game.multiplayer).to eq('mario')
    expect(game.last_played_at).to eq('2002-12-12')
  end
end

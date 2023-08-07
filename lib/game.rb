require_relative 'item'

# this file holds the methods of the game items
class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at)
    super(published_date: Time.now)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    archived?
  end
end

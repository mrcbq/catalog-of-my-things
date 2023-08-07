require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(options = {})
    super(options[:genre], options[:author], options[:source], options[:label], options[:published_date])
    @publisher = options[:publisher]
    @cover_state = options[:cover_state]
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

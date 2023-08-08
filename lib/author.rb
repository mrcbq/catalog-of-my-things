require_relative 'item'

# associated to the item class
class Author
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.author = self
    @items << item
  end

  def generate_id
    @id = rand(1..100)
  end

  private

  attr_reader :id, :items
end

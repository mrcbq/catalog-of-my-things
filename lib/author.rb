require_relative 'item'

# associated to the item class
class Author
  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(new_item)
    return if new_item.author

    new_item.author = self
    @items << new_item
    @items
  end

  private

  def items(new_item)
    add_item(new_item)
  end

  def generate_id
    @id = rand(1..100)
  end
end

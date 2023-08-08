require_relative 'item'

# associated to the item class
class Author
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.author = self
    @items << item
  end
end

require_relative 'item'

# associated to the item class
class Author < Item
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    super(published_date: Time.now)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
  end
end


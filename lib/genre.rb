class Genre
  attr_accessor :name

  def initialize(:name)
    @name = name
    @items = []
  end

  def add_item(new_item)
    return nil unless new_item.is_a?(Item)
    @items << item
    item.genre = self
  end
end

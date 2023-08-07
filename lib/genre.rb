class Genre
  attr_accessor :name

  def initialize(:name)
    @id = id || Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(new_item)
    return nil unless new_item.is_a?(Item)
    @items << item
    item.genre = self
  end

  private

  attr_reader :id, :items
end

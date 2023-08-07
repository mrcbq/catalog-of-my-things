require_relative 'item'

class Label
  attr_accessor :color, :title

  def initialize(id, title)
    @id = id
    @title = title
    @items = []
  end

  def add_item(item)
    return unless item.is_a?(Item)

    item.label = self
    @items << item
  end

  private

  attr_reader :id, :items
end

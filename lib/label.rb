require_relative 'item'

class Label
  attr_accessor :color, :title

  def initialize(id:, title:, color: 'Unknown')
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    return unless item.is_a?(Item)

    item.label = self
    @items << item
  end

  def self.list_all_labels(labels)
    puts 'All Labels:'
    labels.each do |label|
      puts "Label Title: #{label.title}"
    end
  end

  private

  attr_reader :id, :items
end

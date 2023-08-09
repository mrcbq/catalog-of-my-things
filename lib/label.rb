require_relative 'item'

class Label
  attr_accessor :color, :title

  def initialize(id:, title:, color:)
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
    puts '-----------All Labels-----------'
    labels.each do |label|
      puts "Label Title: #{label.title}"
      puts "Label Color: #{label.color}"
    end
  end

  def self.save_all_labels(labels)
    labels_data = labels.map do |label|
      {
        title: label.title,
        color: label.color
      }
    end

    File.write('labels.json', JSON.pretty_generate(labels_data))

    puts 'Labels data saved to labels.json'
  end

  def self.load_all_labels
    if File.exist?('labels.json')
      labels_data = JSON.parse(File.read('labels.json'))
      labels = []

      labels_data.each do |label_data|
        label = Label.new(
          id: label_data['id'],
          title: label_data['title'],
          color: label_data['color']
        )
        labels << label
      end

      labels
    else
      []
    end
  end

  private

  attr_reader :id, :items
end

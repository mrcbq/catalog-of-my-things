class Item
  attr_accessor :published_date
  attr_reader :genre, :author, :label

  def initialize(published_date:)
    @id = id || Random.rand(1..1000)
    @published_date = published_date
    @archived = false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def genre=(new_genre)
    return unless new_genre.is_a?(Genre)

    @genre = new_genre
    new_genre.add_item(self)
  end

  def author=(new_author)
    return unless new_author.is_a?(Author)

    @author = new_author
    author.add_item(self)
  end

  def label=(new_label)
    return unless new_label.is_a?(Label)

    @label = new_label
    label.add_item(self)
  end

  def archived?
    @archived = can_be_archived?
    @archived
  end
  
  private

  attr_reader :id

  def can_be_archived?
    (Date.today - @published_date).to_i >= 3650
  end
end

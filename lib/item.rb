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
    @genre = new_genre
    new_genre.add_item(self)
  end

  def author=(new_author)
    @author = new_author
    author.add_item(self)
  end

  def label=(new_label)
    return if @label == new_label

    @label = new_label
    new_label&.add_item(self)
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

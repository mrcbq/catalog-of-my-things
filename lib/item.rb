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

  private

  attr_reader :id

  def archived?
    @archived
  end

  def can_be_archived?
    true if (Date.today - @published_date).to_i >= 3650
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
    @label = new_label
    label.add_item(self)
  end
end

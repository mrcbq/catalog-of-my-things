class Item
  attr_accessor :published_date

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
    return true if (Date.today - @published_date).to_i >= 3650

    false
  end

  def genre(genre)
    return nil unless genre.is_a?(Genre)

    genre.add_item(self)
    genre
  end

  def author(author)
    return nil unless author.is_a?(Author)

    author.add_item(self)
    author
  end

  def source(source)
    return nil unless source.is_a?(Source)

    source.add_item(self)
    source
  end

  def label(label)
    return nil unless label.is_a?(Label)

    label.add_item(self)
    label
  end
end

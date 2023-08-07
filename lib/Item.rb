class Item
  attr_accessor :id, :genre, :author, :source, :label, :published_date, :archived

  def initialize(id, genre, author, source, label, published_date)
    @id = id || Random.rand(1..1000)
    @genre = set_genre(genre)
    @author = set_author(author)
    @source = set_source(source)
    @label = set_label(label)
    @published_date = published_date
    @archived = false
  end

  private

  def set_genre(genre)
    return nil unless genre.is_a?(Genre)

    genre.items << self
    genre
  end

  def set_author(author)
    return nil unless author.is_a?(Author)

    author.items << self
    author
  end

  def set_source(source)
    return nil unless source.is_a?(Source)

    source.add_item(self)
    source
  end

  def set_label(label)
    return nil unless label.is_a?(Label)

    label.add_item(self)
    label
  end

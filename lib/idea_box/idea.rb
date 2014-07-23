class Idea
  include Comparable

  attr_reader :title,
              :description,
              :rank,
              :id,
              :tags,
              :image

  def initialize(attributes = {})
    @title       = attributes["title"]
    @description = attributes["description"]
    @rank        = attributes["rank"] ||= 0
    @id          = attributes["id"]
    @tags        = attributes["tags"]
    @image       = attributes["image"]
  end

  def <=>(other)
    other.rank <=> rank
  end

  def to_h
    {
      "title"       => title,
      "description" => description,
      "rank"        => rank,
      "id"          => id,
      "tags"        => tags,
      "image"       => image
    }
  end

  def add_tag(tag)
    tags << tag
  end

  def like!
    @rank += 1
  end
end

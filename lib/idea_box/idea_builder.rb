class IdeaBuilder
  def self.build(data)
    id = IdeaStore.size
    tags = data[:tags].split

    idea = data.merge("id" => id, "tags" => tags)
    IdeaStore.create(idea)
  end
end
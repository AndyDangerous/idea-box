class IdeaBuilder
  def self.build(data)
    id = IdeaStore.size
    tags = data[:tags].split

    idea = data.merge("id" => id, "tags" => tags)
    IdeaStore.create(idea)
  end
end


#
#   def self.update(id, data)
#     database.transaction do
#       database['ideas'][id] = data
#     end
#   end
#
#
# def self.create(attributes)
#   database.transaction do
#     database['ideas'] << attributes
#   end
# end

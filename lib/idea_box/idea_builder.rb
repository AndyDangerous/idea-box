class IdeaBuilder
  def self.build(data)
    id = IdeaStore.size
    tags = data[:tags].split

    # if data[:image]
      image = (data[:image][:filename]).to_s
      File.open('public/images/' + data[:image][:filename], "w") do |i|
        i.write(data[:image][:tempfile].read)
      end
    # end

    idea = data.merge("id" => id, "tags" => tags, "image" => image)
    IdeaStore.create(idea)
  end
end
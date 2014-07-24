class IdeaBuilder
  def self.build(data)
    id         = IdeaStore.size
    tags       = data[:tags].split(", ")
    date       = Time.new.to_s

    if data[:image]
      image_name = data[:image][:filename]
      save_image(data[:image])
    # else
    #   image_name = "no_image.png"
    end

    data = data.merge("id"    => id,
                      "tags"  => tags,
                      "image" => image_name,
                      "date"  => date)

    IdeaStore.create(data)
  end

  def self.save_image(data)
    File.open('public/images/' + data[:filename], "w") do |image|
      image.write(data[:tempfile].read)
    end
  end
end
require 'yaml/store'

class IdeaStore
  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find_by_tag(tag)
    all.find_all do |idea|
      idea.tags.include?(tag)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea.merge("id" => id))
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.all
    raw_ideas.map.with_index do |data, i|
      Idea.new(data.merge("id" => i))
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end
  
  def self.weekly_stats
    all.each do |idea|
      
    end
  end

  def self.database
    return @database if @database

    @database ||= YAML::Store.new('db/ideabox')
    @database.transaction do
      @database['ideas'] ||= []
    end
    @database
  end

  def self.size
    all.length
  end

  def self.create(attributes)
    database.transaction do
      database['ideas'] << attributes
    end
  end
end

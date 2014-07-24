class IdeaStats
  def self.weekly_stats
    all_ideas = IdeaStore.all
    
    ideas_by_weekday = all_ideas.day_of_week
    
  end
end
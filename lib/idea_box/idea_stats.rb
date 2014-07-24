class IdeaStats
  def self.week
    production_by_day = IdeaStore.all.group_by_day_of_week{|i| i.date }.map{|k, v| [k, v.size] }
    days_of_the_week = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

    production_by_day.each_with_index do |day, i|
      day[0] = days_of_the_week[i]
    end
  end

  def self.day
    IdeaStore.all.group_by_hour_of_day{|i| i.date }.map{|k, v| [k, v.size] } 
  end
end
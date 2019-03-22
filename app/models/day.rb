class Day < ApplicationRecord

  def passages
    [ot, nt, psalm, proverb]
  end

  def passages_with_names
    {"ot" => ot, "nt" => nt, "ps" => psalm, "pr" => proverb}
  end

  def formatted_devotional
    "<div class='oyb-devotional-title'>Daily Devotional</div><div class='oyb-devotional-author'>Larry Stockstill</div><div class='oyb-devotional'>#{devotional}</div>"
  end

  def self.populate(url)
    Day.all.each do |day|
      Excon.get(url, :headers => {"Authorization" => "Token token=#{ENV['OYB_API_KEY']}"}, :query => {:day => day.to_json(:except => [:devotional, :excerpt])})
    end
  end

  def self.cache_with_redis
    Day.all.each do |day|
      Excon.get("http://oyb.prototyperobotics.com/get_passages?day=#{day.id}")
      puts day.id
    end
  end

  def self.set_values
    Day.all.each do |day|
      day.day_of_month = day.date.strftime("%-d")
      day.month_of_year = day.date.strftime("%-m")
      day.save if day.changed?
    end
  end

end


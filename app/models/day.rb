class Day < ActiveRecord::Base

  def passages
    [ot, nt, psalm, proverb]
  end

  def formatted_devotional
    "<h2>Daily Devotional</h2><i>by Unknown</i><p>#{devotional}"
  end

  def self.populate(url)
    Day.all.each do |day|
      Excon.get(url, :headers => {"Authorization" => "Token token=#{ENV['OYB_API_KEY']}"}, :query => {:day => day.to_json(:except => [:devotional, :excerpt])})
    end
  end

end

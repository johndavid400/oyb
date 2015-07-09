class Day < ActiveRecord::Base

  def passages
    [ot, nt, psalm, proverb]
  end

  def formatted_devotional
    "<h2>Daily Devotional</h2><i>by Unknown</i><p>#{devotional}"
  end

end

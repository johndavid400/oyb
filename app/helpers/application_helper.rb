module ApplicationHelper

  def day_to_date(day)
    if day.to_s.length == 1
      day = "00#{day}"
    elsif day.to_s.length == 2
      day = "0#{day}"
    end
    Date.strptime(day.to_s, "%j").strftime("%B %-d")
  end

  def versions
    # available versions
    {
      "KJV" => "de4e12af7f28f599-01",
      "ASV" => "06125adad2d5898a-01",
      "Free Bible Version" => "65eec8e0b60e656b-01",
    }
  end

end

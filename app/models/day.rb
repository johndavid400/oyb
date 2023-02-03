class Day < ApplicationRecord

  def self.today
    Rails.cache.fetch('days/today', expires_in: 10.minutes) do
      date = Date.today
      Day.find_by(month_of_year: date.strftime("%-m"), day_of_month: date.strftime("%-d"))
    end
  end

  def passages
    passages_with_names.values
  end

  def passages_with_names
    {
      "ot" => ot,
      "nt" => nt,
      "psalm" => psalm,
      "proverb" => proverb
    }
  end

  def get_passages(params = {})
    @token = params['token']

    result = []
    # Default to King James Version if none is specified: "de4e12af7f28f599-01"
    bible_id = params[:bible].present? ? params[:bible] : "de4e12af7f28f599-01"
    # prepend the nav and devotional templates
    result.push(action_controller.render_to_string(:template => 'passages/_nav.html.haml', locals: {day: self, versions: versions, bible: bible_id}, :layout => false))
    result.push(action_controller.render_to_string(:template => 'passages/_devotional.html.haml', locals: {day: self}, :layout => false))

    passages_with_names.each do |section, passages|
      result.push(cached_passage(bible_id, section))
    end

    return result
  end

  def cached_passage(bible_id, section)
    Rails.cache.fetch("#{id}-#{bible_id}-#{section}", expires_in: 12.hours) do
      resp = get_passage(bible_id, section)
      action_controller.render_to_string(:template => 'passages/_passage.html.haml', :layout => false, :locals => {type: section, title: resp['reference'], scriptures: resp['content']})
    end
  rescue
    ''
  end

  def get_passage(bible_id = "de4e12af7f28f599-01", section)
    passage_id = self.send(section)
    client.passages(bible_id, passage_id)
  end

  def formatted_devotional
    "<div class='oyb-devotional-title'>Daily Devotional</div><div class='oyb-devotional-author'>Larry Stockstill</div><div class='oyb-devotional'>#{devotional}</div>"
  end

  def action_controller
    ActionController::Base.new
  end

  def versions
    # available versions
    Rails.cache.fetch("versions-#{@token}", expires_in: 12.hours) do
      bibles = client.bibles.select{|s| user.versions.include?(s["id"]) }
      if bibles.present?
        bibles.map{|s| [s['name'], s['id']] }.to_h
      else
        default_versions
      end
    end
  rescue
    default_versions
  end

  def default_versions
    {
      "KJV" => "de4e12af7f28f599-01",
      "ASV" => "06125adad2d5898a-01",
      "Free Bible Version" => "65eec8e0b60e656b-01",
    }
  end

  def client
    Bible.new(user.try(:api_bible_key))
  end

  def user
    Rails.cache.fetch("user-#{@token}", expires_in: 12.hours) do
      User.find_by(token: @token)
    end
  end

end


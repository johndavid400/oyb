class PassagesController < ApplicationController

  def get_passages
    @result = []
    d = Date.today
    @day = params[:day].present? ? Day.find(params[:day]) : Day.find_by(month_of_year: d.strftime("%-m"), day_of_month: d.strftime("%-d"))
    @version = params[:version].present? ? params[:version] : "eng-KJV"
    if RedisConnection.new.connection.get("oyb#{@day.id}v#{@version}")
      @result = RedisConnection.new.connection.get("oyb#{@day.id}v#{@version}")
    else
      @result.push(render_to_string(:template => 'passages/_nav.html.haml', :layout => false))
      @result.push(render_to_string(:template => 'passages/_devotional.html.haml', :layout => false))
      @day.passages_with_names.each do |k,v|
        passage = v.gsub(/\s/, "+")
        get("passages.js?q[]=#{passage}&version=#{@version}")
        scriptures = @resp["response"]["search"]["result"]["passages"]
        text = render_to_string(:template => 'passages/_passage.html.haml', :layout => false, :locals => {type: k, title: v, scriptures: scriptures})
        @result.push(text)
      end
      RedisConnection.new.connection.set("oyb#{@day.id}v#{@version}", @result.join)
    end
    render :json => @result.to_json
  end

  private

  def get(endpoint)
    base = 'https://bibles.org/v2/'
    url = base + endpoint
    resp = Excon.get(url, :user => ENV["BIBLES_ORG_KEY"], :password => 'X')
    if resp.headers["Location"]
      resp = Excon.get(resp.headers["Location"], :user => ENV["BIBLES_ORG_KEY"], :password => 'X')
    end
    @resp = JSON.parse(resp.body)
  end

end

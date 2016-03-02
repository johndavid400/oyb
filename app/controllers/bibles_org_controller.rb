class BiblesOrgController < ApplicationController

  def index
    @url = "versions.js"
    setup_curl
    @versions = {}
    @resp["response"]["versions"].select{|s| s["lang_name_eng"] == "English" }.map{|s| @versions[s["name"]] = s["id"] }
  end

  def get_passages
    @result = []
    @day = params[:day].present? ? Day.find(params[:day]) : Day.find(Date.today.yday())
    version = "eng-KJV" # test with KJV english
    if RedisConnection.new.connection.get("oyb#{@day.id}v#{version}")
      @result = RedisConnection.new.connection.get("oyb#{@day.id}v#{version}")
    else
      @result.push(render_to_string(:template => 'bibles_org/_nav.html.haml', :layout => false))
      @result.push(render_to_string(:template => 'bibles_org/_devotional.html.haml', :layout => false))
      @day.passages_with_names.each do |k,v|
        passage = v.gsub(/\s/, "+")
        get("passages.js?q[]=#{passage}&version=#{version}")
        scriptures = @resp["response"]["search"]["result"]["passages"]
        text = render_to_string(:template => 'bibles_org/_passage.html.haml', :layout => false, :locals => {type: k, title: v, scriptures: scriptures})
        @result.push(text)
      end
      RedisConnection.new.connection.set("oyb#{@day.id}v#{version}", @result.join)
    end
    render :json => @result.to_json
  end

  def day_to_date(day)
    if day.to_s.length == 1
      day = "00#{day}"
    elsif day.to_s.length == 2
      day = "0#{day}"
    end
    Date.strptime(day.to_s, "%j").strftime("%B %-d")
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

  def bibles_org_post
    format = params[:format]
    resource = "passages"
    version = params[:version]
    passage = params[:input].gsub(/\s/, "+")
    @url = "#{resource}.#{format}?q[]=#{passage}&version=#{version}"
    setup_curl_old
    if params[:response_type] == "raw"
      if params[:format] == "js"
        render json: @result
      else
        render xml: @result
      end
    else
      @format = params[:format]
      render 'passage.html.haml'
    end
  end

  def setup_curl_old
    base = 'https://bibles.org/v2/'
    key = ENV["BIBLES_ORG_KEY"]
    resp = Curl::Easy.new(base + @url)
    resp.ssl_verify_peer = false
    resp.follow_location = true
    resp.max_redirects = 10
    resp.http_auth_types = :basic
    resp.userpwd = "#{key}:X"
    resp.perform
    @result = params[:format] == "js" ? Crack::JSON.parse(resp.body_str) : Crack::XML.parse(resp.body_str)
  end

end

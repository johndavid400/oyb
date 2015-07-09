class BiblesOrgController < ApplicationController

  caches_page :get_passages, :expires_in => 10.minutes

  def index
    @url = "versions.xml"
    setup_curl
    @versions = {}
    @result["response"]["versions"]["version"].select{|s| s["lang_name_eng"] == "English" }.map{|s| @versions[s["name"]] = s["id"] }
  end

  def get_passages
    day = Day.find(Date.today.yday())
    passages = day.passages
    version = "eng-KJV" # test with KJV english
    @result = [].push(day.formatted_devotional)
    passages.each do |p|
      passage = p.gsub(/\s/, "+")
      @url = "passages.js?q[]=#{passage}&version=#{version}"
      setup_curl
      @result.push("<hr>").push("<h2>#{p}</h2>")
      @result.push(@resp["response"]["search"]["result"]["passages"].map{|s| s["text"] }.join("<p>"))
    end
    @text = @result.join("<p>")
    render :json => @text.to_json
  end

  def setup_curl
    base = 'https://bibles.org/v2/'
    key = ENV["BIBLES_ORG_KEY"]
    resp = Curl::Easy.new(base + @url)
    resp.ssl_verify_peer = false
    resp.follow_location = true
    resp.max_redirects = 10
    resp.http_auth_types = :basic
    resp.userpwd = "#{key}:X"
    resp.perform
    @resp = JSON.parse(resp.body_str)
  end

  def bibles_org_post
    format = params[:format]
    resource = "passages"
    version = params[:version]
    passage = params[:input].gsub(/\s/, "+")
    @url = "#{resource}.#{format}?q[]=#{passage}&version=#{version}"
    setup_curl
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

end

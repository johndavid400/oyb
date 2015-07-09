class RedisConnection
  attr_accessor :connection

  def initialize
    if ENV["COTH_REDIS"]
      @connection = Redis.new(:url => ENV["COTH_REDIS"])
    elsif ENV["REDISCLOUD_URL"]
      @connection = Redis.new(:url => ENV["REDISCLOUD_URL"])
    elsif ENV["REDISTOGO_URL"]
      @connection = Redis.new(:url => URI.parse(ENV["REDISTOGO_URL"]))
    elsif ENV["REDIS_URL"]
      @connection = Redis.new(url: ENV["REDIS_URL"])
    else
      @connection = Redis.new
    end
  end

end

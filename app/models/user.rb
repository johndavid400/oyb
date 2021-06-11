class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
         #:confirmable, :trackable

  has_secure_token
  has_secure_token :api_key

  def javascript_include
    "<script src='https://oybplugin.com/oyb.js' data-token='#{token}'></script>"
  end

  def css_include
    "<link href='https://oybplugin.com/oyb.css' media='screen' rel='stylesheet' />"
  end

  def jquery_include
    "<script src='https://code.jquery.com/jquery-2.1.4.min.js'></script>"
  end

  def div_include
    "<div class='oyb'></div>"
  end

  def bible_client
    return Bible.new(api_bible_key)
  end

  def available_versions
    Rails.cache.fetch("#{cache_key_with_version}/available_versions", expires_in: 24.hours) do
      bible_client.bibles.map{|s| [{id: s["id"], name: s["name"], abbv: s["abbreviationLocal"]}] }.flatten
    end
  end

  def selected_versions
    Rails.cache.fetch("#{cache_key_with_version}/selected_versions", expires_in: 24.hours) do
      available_versions.select{|s| versions.include?(s[:id]) }
    end
  end

  def versions
    config.dig('versions')
  rescue
    []
  end

end

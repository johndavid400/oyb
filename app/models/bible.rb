class Bible
  attr_accessor :key, :endpoint, :resp

  def initialize(key = ENV['BIBLES_ORG_KEY'])
    @key = key
  end

  def bibles(params = {language: 'eng'})
    get('bibles', params)
  end

  def bible(bible_id)
    get("bibles/#{bible_id}")
  end

  def books(bible_id, params = {})
    get("bibles/#{bible_id}/books", params)
  end

  def book(bible_id, book_id, params = {})
    # book_id will be something like: "GEN"
    get("bibles/#{bible_id}/books/#{book_id}", params)
  end

  def chapters(bible_id, book_id)
    # book_id will be something like: "GEN"
    get("bibles/#{bible_id}/books/#{book_id}/chapters")
  end

  def chapter(bible_id, chapter_id, params = {})
    # chapter_id will be something like: "GEN.1"
    get("bibles/#{bible_id}/chapters/#{chapter_id}", params)
  end

  def passages(bible_id, passage_id, params = {})
    # passage_id is a string representation of a verse or range of verses:
    # ie. "GEN.1.1-GEN.1.5"
    get("bibles/#{bible_id}/passages/#{passage_id}", params)
  end

  def verses(bible_id, chapter_id)
    get("bibles/#{bible_id}/chapters/#{chapter_id}/verses")
  end

  def verse(bible_id, verse_id, params = {})
    get("bibles/#{bible_id}/verses/#{verse_id}", params)
  end

  private

  def base
    "https://api.scripture.api.bible/v1/"
  end

  def get(endpoint, params = {})
    url = base + endpoint.to_s
    resp = Excon.get(url, query: params, headers: {'api-key': key})
    @resp = JSON.parse(resp.body)['data']
  rescue
    nil
  end

end

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find{|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find{|photograph| photograph.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photo| artist.id == photo.artist_id}
  end

  def artists_with_multiple_photographs
    artist_work_hash.select{|artist, work| work.count > 1}.keys
  end

  def photographs_taken_by_artists_from(country)
    artist_work_hash.select do |artist, work|
      artist.country == country
    end.values.flatten
  end

  def artist_work_hash
    hash = Hash.new{|hash, key| hash[key] = []}
    @artists.each do |artist|
      @photographs.each{|photo| hash[artist] << photo if photo.artist_id == artist.id}
    end
    hash
  end
end

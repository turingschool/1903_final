class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists     = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find {|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find {|photograph| photograph.id == id}
  end

  def artists_with_multiple_photographs
    @artists.find_all {|artist| find_photographs_by_artist(artist).count > 1}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all {|photograph| photograph.artist_id == artist.id}
  end

  def photographs_taken_by_artists_from(country)
    artist_ids = find_artist_ids_by_country(country)
    @photographs.find_all do |photograph|
      artist_ids.include?(photograph.artist_id)
    end
  end

  def find_artist_ids_by_country(country)
    find_artists_by_country(country).map {|artist| artist.id}
  end

  def find_artists_by_country(country)
    @artists.find_all {|artist| artist.country == country}
  end

  def load_photographs(file_path)
    photographs = CSV.table(file_path, force_quotes: true)
    photographs.map do |photo_attributes|
      add_photograph(Photograph.new(photo_attributes))
    end
  end

  def load_artists(file_path)
    artists = CSV.table(file_path, force_quotes: true)
    artists.map do |artist_attributes|
      add_photograph(Photograph.new(artist_attributes))
    end
  end

end

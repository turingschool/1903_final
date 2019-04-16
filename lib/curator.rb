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
    @artists.find { |artist| artist.id == id }
  end

  def find_photograph_by_id(id)
    @photographs.find { |photograph| photograph.id == id }
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all { |photograph| photograph.artist_id == artist.id }
  end

  def artist_with_multiple_photographs
    @artist.s { |artist| find_photographs_by_artist(artist).count > 1 }
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    country = @artists.find_all { |artist| artist.country == country }
    country.flat_map { |artist| find_photographs_by_artist(artist) }
  end
end

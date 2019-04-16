class Curator

  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end

  def photographs_taken_by_artist_from(string)
    artists_from = @artists.find_all do |artist|
      artist.country == string
    end

    artist_ids_from = artists_from.map do |artist|
      artist.id
    end

    @photographs.find_all do |photograph|
      artist_ids_from.include?(photograph.artist_id)
    end
  end

end

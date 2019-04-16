class Curator
  attr_reader :photographs, :artists

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
    @photographs.find do |photo|
      photo.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artist_ids = @photographs.map do |photograph|
      photograph.artist_id
    end
    dupl = artist_ids.find_all do |artist|
      artist_ids.count(artist) > 1
    end
    @artists.find_all do |artist|
      dupl.find do |id|
        id == artist.id
      end
    end
  end
end

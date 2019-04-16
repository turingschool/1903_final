class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    photographs << photograph
  end

  def add_artist(artist)
    artists << artist
  end

  def find_photograph_by_id(find_id)
    photographs.find do |photo|
      photo.id == find_id
    end
  end

  def find_artist_by_id(find_id)
    artists.find do |artist|
      artist.id == find_id
    end
  end

  def find_photographs_by_artist(artist)
    photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    artists.flat_map do |artist|
      if artist.country == country
        find_photographs_by_artist(artist)
      end
    end.compact
  end

  def load_photographs(file_path)
    File.foreach(file_path) do |line|
      info = {
        id: line[0],
        name: line[1],
        artist_id: line[2],
        year: line[3]
      }
      photographs << Photograph.new(info)
    end
    photographs.delete_at(0)
  end
end

require 'csv'
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
    table = CSV.table(file_path)
    table.each do |line|
      info = {
        id: line[:id].to_s,
        name: line[:name],
        artist_id: line[:artist_id].to_s,
        year: line[:year]
      }
      self.add_photograph(Photograph.new(info))
    end
  end

  def load_artists(file_path)
    table = CSV.table(file_path)
    table.each do |line|
      info = {
        id: line[:id].to_s,
        name: line[:name].to_s,
        born: line[:born].to_s,
        died: line[:died].to_s,
        country: line[:country].to_s
      }
      self.add_artist(Artist.new(info))
    end
  end

  def photographs_taken_between(range)
    photographs.find_all do |photo|
      range.any? do |year|
        photo.year == year
      end
    end
  end

  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)
    hash = {}
    photos.each do |photo|
      age = photo.year - artist.born.to_i
      hash[age] = photo.name
    end
    hash
  end
end

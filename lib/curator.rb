require 'csv'

class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
    @photograph_data = {}
    @artist_data = {}
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      id == artist.id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      id == photo.id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def find_photographs_taken_by_artist_from(country)
    @photos_matching_country = []
    @artists_matching_country = @artists.find_all do |artist|
      artist.country == country
    end
    @artists_matching_country.each do |artist|
      @photos_matching_country << find_photographs_by_artist(artist)
    end
    @photos_matching_country.flatten
  end

  def artists_with_multiple_photographs
    @artist_ids = @photographs.map do |photo|
      photo.artist_id
    end
    duplicate_ids = @artist_ids.select { |id| @artist_ids.count(id) > 1 }
    duplicate_ids.uniq.map do |id|
      find_artist_by_id(id)
    end
  end

  def load_photographs(file)
    @photograph_data = CSV.table(file)
    @photograph_data.inject({}) do |photo_hash, photo_row|
      new_key = photo_row[:id].to_s + "-" + photo_row[:year].to_s
      photo_hash[new_key] = photo_row
      photo_hash
    end
  end

  def load_artists(file)
    @artist_data = CSV.table(file)
    @artist_data.inject({}) do |artist_hash, artist_row|
      new_key = artist_row[:id].to_s + "-" + artist_row[:name].to_s
      artist_hash[new_key] = artist_row
      artist_hash
    end
  end

  def photographs_taken_between(year_range)
    @photos_in_range = []
    @photograph_data.find_all do |photo|
      if year_range.include?(photo[:year])
        @photos_in_range << photo[:name]
      end
    end
    @photos_in_range
  end

  # def artists_photographs_by_age(artist_name)
  #   @photographs_data.each do |photo|
  #     photo[:year] -
  #   end
  # end

end

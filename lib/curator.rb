
require 'csv'
class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists     = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id_num)
    @artists.find do |artist|
      artist.id == id_num
      binding.pry
    end
  end

  def find_photograph_by_id(pic_num)
    @photographs.find do |photo|
      photo.id == pic_num
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      artist.id == photo.artist_id
    end
  end

  def artists_with_multiple_photographs
    photo_by_artist = []
    @photographs.sort_by do |photo|
      photo_by_artist << photo.artist_id
    end

    artist = []
    photo_by_artist.find do |id|
      if photo_by_artist.count(id) > 1
         artist << find_artist_by_id(id)
      end
    end
    artist
  end

  def photographs_taken_by_artist_from(country)
    @artists.find_all do |artist|
      artist.country == country
    end
  end

  def load_photographs(location)
    CSV.foreach(location, {:headers => true, :header_converters => :symbol}) do |row|
      @photographs << Photograph.new(row)
    end
    @photographs
  end

  def load_artists(location)
    CSV.foreach(location, {:headers => true, :header_converters => :symbol}) do |row|
      @artists << Artist.new(row)
    end
    @artists
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range.cover?(photo.year.to_i)
    end
  end
#
#   def artists_photographs_by_age(artist)
#     photo_age_hash = {}
# binding.pry
#     photo_age_hash = @photographs.group_by do |photo|
#       binding.pry
#       photo.year
#     end
#
#     photo_age_hash.find_all do |photo|
#
#       binding.pry
#     end
  #
  # end


end

require 'pry'
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

  def find_artist_by_id(artist_id)
    @artists.find do |artist|
      artist.id == artist_id
    end
  end

  def find_photograph_by_id(photo)
    @photographs.find do |photograph|
      photograph.id == photo
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    multiple_photos = @photographs.map do |photograph|
      photograph.artist_id
    end
    multi_photo_artist = multiple_photos.detect {|artist_id| multiple_photos.count(artist_id) > 1}
     if @artists[id] == multi_photo_artist
       return @artists
     end
  end

  def photographs_taken_by_artist_from(country)
    photos_by_artist_id = @photographs.find_all do |photograph|
      photograph.artist_id
    end
    photos_by_artist_id
  end
end

# binding.pry

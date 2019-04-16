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


end

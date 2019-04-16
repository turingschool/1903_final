class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find{|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find{|photo| photo.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photo| photo.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    artists_ids = []
    multiple_photo_artist_ids = []
    @photographs.each do |photo|
      if artists_ids.include?(photo.artist_id)
        multiple_photo_artist_ids << photo.artist_id
      end
      artists_ids << photo.artist_id
    end
    multiple_photo_artist_ids.map do |id|
      @artists.find{|artist| artist.id == id}
    end
  end

  def photographs_taken_by_artist_from(origin)
    photos_in_origin = []
    artists_in_origin = @artists.find_all{|artist| artist.country == origin}
    artists_in_origin.each do |artist|
      @photographs.each do |photo|
        photos_in_origin << photo if photo.artist_id == artist.id
      end
    end
    photos_in_origin
  end
  
end

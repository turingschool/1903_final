require 'csv'

class Curator
  attr_reader :photographs,
              :artists,
              :file_path,
              :csv_photos,
              :csv_artists

  def initialize(filepath = nil)
    @filepath = filepath
    @photographs = []
    @artists = []
    @csv_photos = csv_photos
    @csv_artists = csv_artists
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id}
  end

  def find_photographs_by_artist(artist)
    photos_by_artist = []
    @photographs.each do |photograph|
       if photograph.artist_id == artist.id
         photos_by_artist << photograph
       end
    end
    photos_by_artist
  end

  def artists_with_multiple_photographs
    photos_by_id =  @photographs.group_by { |photo| photo.artist_id}
    artists_with_multiple_photos = []

    photos_by_id.each do |id|
      if id[1].count > 1
        artists_with_multiple_photos << find_artist_by_id(id[0])
      end
    end
    artists_with_multiple_photos
  end


  def load_photographs(file)
    @csv_photos = CSV.read(file, { headers: true,
     converters: :numeric,
     header_converters: :symbol }.merge(Hash.new) )
  end

  def load_artists(file)
    @csv_artists = CSV.read(file, { headers: true,
     converters: :numeric,
     header_converters: :symbol }.merge(Hash.new) )
  end

  def photographs_taken_between(date)
    photos = []
    @csv_photos.each do |photo|
      photos << photo if photo[:year] > date.first && photo[:year] < date.last
    end
    photos
  end

  
end

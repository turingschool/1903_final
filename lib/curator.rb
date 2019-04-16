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
    @photographs.find{|photograph| photograph.id == id}
  end

  def find_photograph_by_artist(artist)
    @photographs.find_all do |photograph|
        photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photograph_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    array_of_photographs_by_artist = []
    @artists.find_all do |artist|
      if artist.country == country
        array_of_photographs_by_artist << find_photograph_by_artist(artist)
      end
    end
    array_of_photographs_by_artist.flatten
  end

  def load_photographs(file_location)
    CSV.foreach(file_location,{ headers: true, header_converters: :symbol }) do |row|
      @photographs << Photograph.new(row)
    end
  end

  def load_artists(file_location)
    CSV.foreach(file_location,{ headers: true, header_converters: :symbol }) do |row|
      @artists << Artist.new(row)
    end
  end

  def photographs_taken_between(year_range)
    photos = []
    @photographs.each do |photograph|
     year = photograph.year.to_i
      if (year_range).include?(year)
       photos << photograph
      end
    end
    photos
  end

  def artists_photographs_by_age(artist)
    hash_of_age_to_painting = {}
    array_of_photos = find_photograph_by_artist(artist)
    array_of_photos.each do |photo|
      hash_of_age_to_painting[(artist.born.to_i - photo.year.to_i).abs] = photo.name
    end
      hash_of_age_to_painting
  end

end

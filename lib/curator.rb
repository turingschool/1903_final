class Curator

  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_artist(artist)
    @artists << artist
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def find_artist_by_id(id)
    @artists.find{|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find{|photo| photo.id == id}
  end

  def artists_with_multiple_photographs
    @artists.select do |artist|
       photos = @photographs.select{|photo| photo.artist_id == artist.id}
       photos.length > 1
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.select{|photo| photo.artist_id == artist.id}
  end

  def photographs_by_artists_from(country)
    artists = @artists.select { |artist| artist.country == country}
    artists.map{|artist|find_photographs_by_artist(artist)}.flatten
  end

  def load_photographs
    photo_table = CSV.table('./data/photographs.csv')
    @photographs = photo_table.map{|photo_info| Photograph.new(photo_info)}
  end

  def load_artists
    artist_table = CSV.table('./data/artists.csv')
    @artists = artist_table.map{|artist_info| Artist.new(artist_info)}
  end

  def photographs_taken_between(range)
    @photographs.select  do |photo|
      year = photo.year.to_i
      range.include?(year)
     end
  end

  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)
    photos.reduce({}) do |memo, photo|
      memo[( photo.year.to_i - artist.born.to_i)] = photo.name
      memo
    end
  end

end

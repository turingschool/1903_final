require './lib/photo'
require './lib/artist'

class Curator
  attr_reader :artists, :photos
  def initialize; @artists = {}; @photos = []; @num_by_artist = Hash.new(0) end

  def load_photos(file)
    lines = IO.readlines(file)
    lines.shift
    lines.each do |line|
      words = line.chomp.split(/,/)
      photo = Photo.new({id: words[0], name: words[1], artist_id: words[2], \
        year: words[3]})
      @photos << photo
    end
  end

  def load_artists(file)
    lines = IO.readlines(file)
    lines.shift
    lines.each do |line|
      words = line.chomp.split(/,/)
      artist = Artist.new({id: words[0], name: words[1], born: words[2], \
        died: words[3], country: words[4]})
      @artists[words[0]] = artist
    end
  end

  def add_artist(artist); @artists[artist.id] = artist end
  def add_photo(photo)
    @photos << photo
    @num_by_artist[photo.artist_id] += 1
  end

  def find_artist_id(id)
    return @artists.values.find {|x| x.id == id}
  end

  def find_photo_id(id)
    return @photos.find {|x| x.id == id}
  end

  def find_by_artist(artist)
    return @photos.find_all {|x| x.artist_id == artist.id}
  end

  def artists_with_multiple_photos
    return @artists.values.find_all {|x| @num_by_artist[x.id] > 1}
  end

  def taken_by_artist_from(country)
    return @photos.find_all {|x| @artists[x.artist_id].country == country}
  end

  def photos_taken_between(range)
    return @photos.find_all {|x| range.include?(x.year.to_i)}
  end

  def artist_photos_by_age(artist)
    hash = {}
    @photos.find_all {|x| x.artist_id == artist.id}.map do |photo|
      hash[(photo.year.to_i - artist.born.to_i)] = photo.name
    end
    return hash
  end
end
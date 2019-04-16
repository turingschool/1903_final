require 'csv'

class Curator
  attr_reader :photographs, :artists

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

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photo| artist.id == photo.artist_id}
  end

  def artists_with_multiple_photographs
    artist_work_hash.select{|artist, work| work.count > 1}.keys
  end

  def photographs_taken_by_artists_from(country)
    artist_work_hash.select do |artist, work|
      artist.country == country
    end.values.flatten
  end

  def load_photographs(file)
    photos = CSV.open(file, :headers => true, :header_converters => :symbol)
    @photographs = photos.map do |photo|
      Photograph.new(photo.to_hash)
    end
  end

  def load_artists(file)
    artists = CSV.open(file, :headers => true, :header_converters => :symbol)
    @artists = artists.map do |artist|
      Artist.new(artist.to_hash)
    end
  end

  def photographs_taken_between(range)
    @photographs.select{|photo| range.member?(photo.year.to_i)}
  end

  def artists_photographs_by_age(input_artist)
    hash = Hash.new
    artist_work_hash.each do |artist, work|
      if input_artist == artist
        work.each do |photo|
          age = 0
          age = photo.year.to_i - artist.born.to_i
          hash[age] = photo.name
        end
      end
    end
    hash
  end

  def artist_work_hash
    hash = Hash.new{|hash, key| hash[key] = []}
    @artists.each do |artist|
      @photographs.each{|photo| hash[artist] << photo if photo.artist_id == artist.id}
    end
    hash
  end
end

require 'csv'
require './lib/photograph'
require './lib/artist'

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

  def load_artists(path)
    artists = CSV.read(path, {headers: true, header_converters: :symbol})
    artists.by_row.each do |artist|
      attributes = {
        id: artist[:id],
        name: artist[:name],
        born: artist[:born],
        died: artist[:died],
        country: artist[:country]
      }
      @artists << Artist.new(attributes)
    end
  end

  def load_photographs(path)
    photos = CSV.read(path, {headers: true, header_converters: :symbol})
    photos.by_row.each do |photo|
      attributes = {
        id: photo[:id],
        name: photo[:name],
        artist_id: photo[:artist_id],
        year: photo[:year]
      }
      @photographs << Photograph.new(attributes)
    end
  end

  def photographs_taken_between(range)
    photos = []
    @photographs.each do |photo|
      photos << photo if range.to_a.include?(photo.year.to_i)
    end
    photos
  end

  def artists_photographs_by_age(artist)
    photos_by_age = {}
    @photographs.each do |photo|
      if photo.artist_id == artist.id
        age = photo.year.to_i - artist.born.to_i
        photos_by_age[age] = photo.name
      end
    end
    photos_by_age
  end
end

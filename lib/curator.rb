require "CSV"
require "./lib/artist"
require "./lib/photograph"

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
    @photographs.find{|photo| photo.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photo| photo.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    multiple_photos = []
    @artists.each do |artist|
      multiple_photos << artist if \
      @photographs.count{|photo| photo.artist_id == artist.id} > 1
    end
    multiple_photos
  end

  def photographs_taken_by_artist_from(country)
    photos_by_country = []
    @artists.each do |artist|
      if artist.country == country
        @photographs.each{|photo| photos_by_country << photo \
          if photo.artist_id == artist.id}
      end
    end
    photos_by_country
  end

  def load_photographs(filepath)
    abort("File not found") if !File.readable?(filepath)
    CSV.foreach(filepath, :headers => true, :header_converters => :symbol) do |row|
      attributes = {
        :id => row[:id],
        :name => row[:name],
        :artist_id => row[:artist_id],
        :year => row[:year]
      }
      @photographs << Photograph.new(attributes)
    end
  end

  def load_artists(filepath)
    abort("File not found") if !File.readable?(filepath)
    CSV.foreach(filepath, :headers => true, :header_converters => :symbol) do |row|
      attributes = {
        :id => row[:id],
        :name => row[:name],
        :born => row[:born],
        :died => row[:died],
        :country => row[:country]
      }
      @artists << Artist.new(attributes)
    end
  end

  def photographs_taken_between(range)
    @photographs.select{|photo| range.include? photo.year.to_i}
  end

  def artists_photographs_by_age(artist)

  end

end

require './lib/artist'
require './lib/photograph'
require 'CSV'

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
    @artists.find { |artist| artist.id.eql? id }
  end

  def find_photograph_by_id(id)
    @photographs.find { |photo| photo.id.eql? id }
  end

  def find_photographs_by_artist(artist)
    @photographs.select { |photo| photo.artist_id.eql? artist.id  }
  end

  def artists_with_multiple_photographs
    @artists.select { |artist| find_photographs_by_artist(artist).count > 1 }
  end

  def photographs_taken_by_artist_from(country)
    @photographs.select { |photo| find_artist_by_id(photo.artist_id).country.eql? country }
  end

  def load_photographs(file_path)
    csv_table = CSV.read(File.open(file_path), headers: true, header_converters: :symbol)
    csv_table.each { |photo| @photographs << Photograph.new(photo.to_h) }
  end

  def load_artists(file_path)
    csv_table = CSV.read(File.open(file_path), headers: true, header_converters: :symbol)
    csv_table.each {|artist| @artists << Artist.new(artist.to_h)}
  end

  def photographs_taken_between(range)
    @photographs.select { |photo| range === photo.year.to_i }
  end
end

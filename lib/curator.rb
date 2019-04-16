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

  def add_photograph(photograph_obj)
    @photographs << photograph_obj
  end

  def add_artist(artist_obj)
    @artists << artist_obj
  end

  def find_artist_by_id(artist_id)
    @artists.find do |artist_obj|
      artist_obj.id == artist_id
    end
  end

  def find_photograph_by_id(photograph_id)
    @photographs.find do |photograph_obj|
      photograph_obj.id == photograph_id
    end
  end

  def find_photographs_by_artist(artist_obj)
    artist_id = artist_obj.id
    @photographs.find_all do |photograph_obj|
      photograph_obj.artist_id == artist_id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist_obj|
      find_photographs_by_artist(artist_obj).count > 1
    end
  end

  def photographs_taken_by_artists_from(country_name)
    @photographs.find_all do |photograph_obj|
      artist_id = photograph_obj.artist_id
      artist_obj = @artists.find { |artist_obj| artist_obj.id == artist_id }
      artist_obj.country == country_name
    end
  end

  def load_photographs(filepath)
    photo_data = CSV.table(filepath)
    photo_data.each do |photo_file_row|
      attributes_hash = {
        id: photo_file_row[:id].to_s,
        name: photo_file_row[:name],
        artist_id: photo_file_row[:artist_id].to_s,
        year: photo_file_row[:year].to_s
      }
      photograph_obj = Photograph.new(attributes_hash)
      add_photograph(photograph_obj)
    end
  end
end

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

  def photographs_taken_by_artist_from(country_name)
    @photographs.find_all do |photograph_obj|
      artist_id = photograph_obj.artist_id
      artist_obj = @artists.find { |artist_obj| artist_obj.id == artist_id }
      artist_obj.country == country_name
    end
  end

  def load_photographs(filepath)
    photo_data = CSV.table(filepath)
    photo_data.each do |photo_file_row|
      attributes_hash = photo_data.headers.inject({}) do |attr_hash, header|
        attr_hash[header] = photo_file_row[header].to_s
        attr_hash
      end
      add_photograph(Photograph.new(attributes_hash))
    end
  end

  def load_artists(filepath)
    artist_data = CSV.table(filepath)
    artist_data.each do |artist_file_row|
      attributes_hash = artist_data.headers.inject({}) do |attr_hash, header|
        attr_hash[header] = artist_file_row[header].to_s
        attr_hash
      end
      add_artist(Artist.new(attributes_hash))
    end
  end

  def photographs_taken_between(range_of_years)
    @photographs.find_all do |photograph_obj|
      range_of_years.to_a.include?(photograph_obj.year.to_i)
    end
  end

  def artists_photographs_by_age(artist_obj)
    all_artist_photos = find_photographs_by_artist(artist_obj)
    all_artist_photos.inject({}) do |hash_builder, photograph_obj|
      age = photograph_obj.year.to_i - artist_obj.born.to_i
      hash_builder[age] = photograph_obj.name
      hash_builder
    end
  end
end

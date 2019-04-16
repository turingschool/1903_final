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
end

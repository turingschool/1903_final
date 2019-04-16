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
end

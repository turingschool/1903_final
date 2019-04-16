class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    photographs << photograph
  end

  def add_artist(artist)
    artists << artist
  end

  def find_photograph_by_id(find_id)
    photographs.find do |photo|
      photo.id == find_id
    end
  end
end

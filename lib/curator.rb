class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists     = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id_num)
    @artists.find do |artist|
      artist.id == id_num
    end
  end

  def find_photograph_by_id(pic_num)
    @photographs.find do |photo|
      photo.id == pic_num
    end
  end


end

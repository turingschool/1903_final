class Curator

  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(artist_id)
    @artists.find{|artist| artist.id == artist_id}
  end

  def find_photograph_by_id(photograph)
    @photographs.find{|photo| photo.id == photograph}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photo| photo.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    final_ids = []
      paintings_by_artist_id.each do |id, collection|
        final_ids << id if collection.count >= 2
    end
    @artists.find_all {|artist| final_ids.include?(artist.id)}
  end

  def photographs_taken_by_artists_from(country)
    collection = []
    @artists.each do |a|
      @photographs.each do |p|
        collection << p if a.country == country && a.id == p.artist_id
      end
    end
    collection
  end

  def paintings_by_artist_id
    @photographs.group_by{|photograph| photograph.artist_id}
  end

  def load_photographs(file)

  end

  def load_artists(file)

  end

  def photographs_taken_between(range)

  end

  def artists_photographs_by_age(artist)

  end

end

class Photo
  attr_reader :id, :name, :artist_id, :year
  def initialize(hash)
    @id = hash[:id]; @name = hash[:name]
    @artist_id = hash[:artist_id]; @year = hash[:year]
  end

  def ==(x)
    return self.class == x.class \
      && self.id == x.id \
      && self.name == x.name \
      && self.artist_id == x.artist_id \
      && self.year == x.year
  end
end
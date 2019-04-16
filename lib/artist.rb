class Artist
  attr_reader :id, :name, :born, :died, :country
  def initialize(hash)
    @id = hash[:id]; @name = hash[:name]
    @born = hash[:born]; @died = hash[:died]
    @country = hash[:country]
  end

  def ==(x)
    return self.class == x.class \
      && self.id == x.id \
      && self.name == x.name \
      && self.born == x.born \
      && self.died == x.died \
      && self.country == x.country
  end
end
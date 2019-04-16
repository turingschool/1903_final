class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(attributes_hash)
    @id = attributes_hash[:id]
    @name = attributes_hash[:name]
    @artist_id = attributes_hash[:artist_id]
    @year = attributes_hash[:year]
  end
end

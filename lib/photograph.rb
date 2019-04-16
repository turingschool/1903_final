class Photograph

  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(attributes)
    @id = attributes[:id].to_s
    @name = attributes[:name]
    @artist_id = attributes[:artist_id].to_s
    @year = attributes[:year]
  end
end

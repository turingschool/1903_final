class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(id:, name:, artist_id:, year:)
    @id        = id
    @name      = name
    @artist_id = artist_id
    @year      = year
  end
end

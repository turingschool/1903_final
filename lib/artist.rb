class Artist
  attr_reader :id,
              :name,
              :born,
              :died,
              :country

  def initialize(id:, name:, born:, died:, country:)
    @id      = id
    @name    = name
    @born    = born
    @died    = died
    @country = country
  end

end

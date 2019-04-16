class Artist
  attr_reader :id,
              :name,
              :born,
              :died,
              :country

  def initialize(attributes_hash)
    @id = attributes_hash[:id]
    @name = attributes_hash[:name]
    @born = attributes_hash[:born]
    @died = attributes_hash[:died]
    @country = attributes_hash[:country]
  end
end

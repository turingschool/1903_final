class Artist

  attr_reader :id,
              :name,
              :born,
              :died,
              :country

  def initialize(attributes)
    @id = attributes[:id].to_s
    @name = attributes[:name].to_s
    @born = attributes[:born].to_s
    @died = attributes[:died].to_s
    @country = attributes[:country].to_s
  end
end

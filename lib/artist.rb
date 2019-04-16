require 'pry'
class Artist
  attr_reader :id, :name, :born, :died, :country
  def initialize(attrib)
    @id = attrib[:id]
    @name = attrib[:name]
    @born = attrib[:born]
    @died = attrib[:died]
    @country = attrib[:country]
  end
end

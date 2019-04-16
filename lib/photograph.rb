require 'pry'
class Photograph
  attr_reader :id, :name, :artist_id, :year
  def initialize(attrib)
    @id = attrib[:id]
    @name = attrib[:name]
    @artist_id = attrib[:artist_id]
    @year = attrib[:year]
  end
end

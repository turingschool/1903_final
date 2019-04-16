class Photograph

  attr_reader :id, :name, :artist_id, :year

  def initialize(info)
    @name = info[:name].to_s
    @id = info[:id].to_s
    @artist_id = info[:artist_id].to_s
    @year = info[:year].to_s
  end

end

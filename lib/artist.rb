class Artist

  attr_reader :name, :id, :born, :died, :country
  
  def initialize(info)
    @name = info[:name].to_s
    @id = info[:id].to_s
    @born = info[:born].to_s
    @died = info[:died].to_s
    @country = info [:country].to_s
  end

end

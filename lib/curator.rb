require './lib/photograph'

class Curator
  attr_reader :photographs

  def initialize
    @photographs = []
  end

  def add_photograph(photograph_obj)
    @photographs << photograph_obj
  end
end

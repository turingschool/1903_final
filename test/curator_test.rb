require './test/test_helper'
require './lib/curator'
require './lib/photograph'
class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @rue = Photograph.new({id: "1", name: "Rue Mouffetard, Paris (Boy with Bottles)", artist_id: "4", year: "1954"})
    @moonrise = Photograph.new({id: "2", name: "Moonrise, Hernandez", artist_id: "2", year: "1941"})
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_no_photographs
    assert_empty @curator.photographs
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@rue)
    @curator.add_photograph(@moonrise)

    assert_equal [@rue, @moonrise], @curator.photographs
  end
end

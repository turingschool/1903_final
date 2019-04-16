require './test/test_helper'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @rue = Photograph.new({id: "1", name: "Rue Mouffetard, Paris (Boy with Bottles)", artist_id: "4", year: "1954"})
    @moonrise = Photograph.new({id: "2", name: "Moonrise, Hernandez", artist_id: "2", year: "1941"})
    @ansel = Artist.new({id: "2", name: "Ansel Adams", born: "1902", died: "1984", country: "United States"})
    @henri = Artist.new({id: "1", name: "Henri Cartier-Bresson", born: "1908", died: "2004", country: "France"})
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

  def test_it_starts_with_no_artists
    assert_empty @curator.artists
  end

  def test_it_can_add_artists
    @curator.add_artist(@ansel)
    @curator.add_artist(@henri)

    assert_equal [@ansel, @henri], @curstor.artists
  end
end

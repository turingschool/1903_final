require "./test/test_helper"
require "./lib/photograph"
require "./lib/artist"
require "./lib/curator"

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })
    @photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })
    @photo_3 = Photograph.new({    
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })
    @photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })
    @artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })
    @artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })
    @artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_can_add_photographs
    assert_equal @curator.photographs, []
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @curator.photographs, [@photo_1, @photo_2]
  end

  def test_it_can_add_artists
    assert_equal @curator.artists, []
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @curator.artists, [@artist_1, @artist_2]
  end

  def test_it_can_find_artist_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @curator.find_artist_by_id("1"), @artist_1
    assert_equal @curator.find_artist_by_id("2"), @artist_2
  end

  def test_it_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @curator.find_photograph_by_id("1"), @photo_1
    assert_equal @curator.find_photograph_by_id("2"), @photo_2
  end

end

require 'minitest/autorun'
require 'minitest/emoji'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

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

    @photo_3  = Photograph.new({
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

    @artist_4 = Artist.new({
     id: "4",
     name: "Brian Plantico",
     born: "1990",
     died: "n/a",
     country: "United States"
     })

  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_photographs_initializes_empty
    assert_equal [], @curator.photographs
  end

  def test_add_photo_method
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_artists_initializes_empty
    assert_equal [], @curator.artists
  end

  def test_add_artist_method_adds_to_artists_array
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_can_find_artist_by_id_again
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_2, @curator.find_artist_by_id("2")
  end

  def test_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_1, @curator.find_photograph_by_id("1")
  end

  def test_can_find_photograph_by_id_again
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    @curator.add_photograph(@photo_1) # artist_id == "1"
    @curator.add_photograph(@photo_2) # artist_id == "2"
    @curator.add_photograph(@photo_3) # artist_id == "3"
    @curator.add_photograph(@photo_4) # artist_id == "3"

    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_it_can_find_photographs_by_artist_again
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_artist(@artist_4)

    @curator.add_photograph(@photo_1) # artist_id == "1"
    @curator.add_photograph(@photo_2) # artist_id == "2"
    @curator.add_photograph(@photo_3) # artist_id == "3"
    @curator.add_photograph(@photo_4) # artist_id == "3"

    assert_equal [@photo_1], @curator.find_photographs_by_artist(@artist_1)
    assert_equal [], @curator.find_photographs_by_artist(@artist_4)
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_artist(@artist_4)

    @curator.add_photograph(@photo_1) # artist_id == "1"
    @curator.add_photograph(@photo_2) # artist_id == "2"
    @curator.add_photograph(@photo_3) # artist_id == "3"
    @curator.add_photograph(@photo_4) # artist_id == "3"

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

end

# pry(main)> curator.photographs_taken_by_artist_from("United States")
# # => [#<Photograph:0x00007fabc6c28e58...>, #<Photograph:0x00007fabc5bb9ef0...>, #<Photograph:0x00007fabc6b931f0...>
#
# pry(main)> curator.photographs_taken_by_artist_from("Argentina")
# # => []

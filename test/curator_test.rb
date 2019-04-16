require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
require 'csv'

class CuratorTest < MiniTest::Test

  def setup
    @photo_1 = Photograph.new({id:        "1",
                               name:      "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year:      "1954"})

    @photo_2 = Photograph.new({id:        "2",
                               name:      "Moonrise, Hernandez",
                               artist_id: "2",
                               year:      "1941"})

    @photo_3 = Photograph.new({id:        "3",
                               name:      "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year:      "1967"})

    @photo_4 = Photograph.new({id:        "4",
                               name:      "Monolith, The Face of Half Dome",      artist_id: "3",
                               year:      "1927"})

    @artist_1 = Artist.new({id:      "1",
                            name:    "Henri Cartier-Bresson",
                            born:    "1908",
                            died:    "2004",
                            country: "France"})

    @artist_2 = Artist.new({id:      "2",
                            name:    "Ansel Adams",
                            born:    "1902",
                            died:    "1984",
                            country: "United States"})

    @artist_3 = Artist.new({id:      "3",
                            name:    "Diane Arbus",
                            born:    "1923",
                            died:    "1971",
                            country: "United States"})

    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_by_default_it_has_no_photographs
    assert_empty @curator.photographs
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_by_default_it_has_no_artists
    assert_empty @curator.artists
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_an_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_a_photo_graph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_all_artists_by_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@artist_2, @artist_3], @curator.find_artists_by_country("United States")
  end

  def test_it_can_find_all_artist_ids_by_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal ["2", "3"], @curator.find_artist_ids_by_country("United States")
  end

  def test_it_can_find_all_photographs_taken_by_artists_from_a_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_taken_by_artists_from("United States")

    assert_empty @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs_from_a_csv
    @curator.load_photographs('./data/photographs.csv')

    assert_equal [@photo_1, @photo_2, @photo_3, @photo_4], @curator.photographs
  end

  def test_it_can_load_artists_from_a_csv
    skip
    @curator.load_photographs('./data/artists.csv')

    assert_equal [@artist_1, @artist_2, @artist_3], @curator.artists
  end

end

# * `photographs_taken_between(range)` - This method takes a range and returns an array of all photographs with a year that falls in that range.
# * `artists_photographs_by_age(artist)`- This method takes an `Artist` object and return a hash where the keys are the Artists age when they took a photograph, and the values are the names of the photographs.

# pry(main)> curator.photographs_taken_between(1950..1965)
# #=> [#<Photograpah:0x00007fd986254740...>, #<Photograph:0x00007fd986254678...>]
#
# pry(main)> diane_arbus = curator.find_artist_by_id("3")
#
# pry(main)> curator.artists_photographs_by_age(diane_arbus)
# => {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
# ```

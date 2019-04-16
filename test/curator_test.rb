require 'minitest/pride'
require 'minitest/autorun'
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

  def test_curator_class_exists
    assert_instance_of Curator, @curator
  end

  def test_photographs_array_initializes_empty
    assert_equal [], @curator.photographs
  end

  def test_add_photograph_method_adds_photo_argument_to_photographs_array
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_artists_array_initializes_empty
    assert_equal [], @curator.artists
  end

  def test_add_artist_method_adds_artist_argrument_to_artists_array
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_find_artist_by_id_returns_artist_object_with_matching_id_argument
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_find_photograph_by_id_returns_photograph_object_with_matching_id_argument
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_find_photographs_by_artist_method_returns_artist_object_matching_argument
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_artists_with_multiple_photographs_returns_array_with_artists_with_more_than_one_photo
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_photographs_taken_by_artist_from_returns_arists_from_argument
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_2, @photo_3, @photo_4], @curator.find_photographs_taken_by_artist_from("United States")
    assert_equal [], @curator.find_photographs_taken_by_artist_from("Argentina")
  end

  def test_photographs_taken_between_returns_photos_taken_between_argument_range
    @curator.load_photographs('./data/photographs.csv')
    assert_equal ["Rue Mouffetard, Paris (Boy with Bottles)", "Child with Toy Hand Grenade in Central Park"], @curator.photographs_taken_between(1950..1965)
  end

  # def test_artist_photographs_by_age_returns_hash_with_age_value_and_photo_name
  #   diane_arbus = @curator.find_artist_by_id("3")
  #   expected = {44=>"Identical Twins, Roselle, New Jersey",
  #               39=>"Child with Toy Hand Grenade in Central Park"
  #             }
  #   @curator.load_artists('./data/artists.csv')
  #   assert_equal expected, @curator.artists_photographs_by_age(diane_arbus)
  # end

end

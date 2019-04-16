require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @photo_1 = Photograph.new({id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"})
    @photo_2 = Photograph.new({id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"})
    @photo_3 = Photograph.new({id: "3",
                               name: "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year: "1967"})
    @photo_4 = Photograph.new({id: "4",
                               name: "Monolith, The Face of Half Dome",
                               artist_id: "3",
                               year: "1927"})
    @artist_1 = Artist.new({id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"})
    @artist_2 = Artist.new({id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"})
    @artist_3 = Artist.new({id: "3",
                            name: "Diane Arbus",
                            born: "1923",
                            died: "1971",
                            country: "United States"})
  end

  def setup_iteration_3
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
  end

  def test_it_class_exist
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_add_photograph
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_can_add_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    setup_iteration_3

    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_it_can_return_artists_with_multiple_photographs
    setup_iteration_3

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_it_can_return_photographs_taken_by_artists_from_country
    setup_iteration_3

    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_taken_by_artists_from("United States")
    assert_equal [], @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs_csv_files
    @curator.load_photographs('./data/photographs.csv')

    assert_equal 4, @curator.photographs.length
  end

  def test_it_can_load_artists_csv_files
    @curator.load_artists('./data/artists.csv')

    assert_equal 6, @curator.artists.length
  end

  def test_it_can_find_photographs_between_range
    setup_iteration_3

    assert_equal [@photo_1],@curator.photographs_taken_between(1950..1965)
  end

  def test_it_can_find_artists_photographs_by_age
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    diane_arbus = curator.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}

    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end
end

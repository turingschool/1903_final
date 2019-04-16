require './test/test_helper'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @rue = Photograph.new({id: "1", name: "Rue Mouffetard, Paris (Boy with Bottles)", artist_id: "4", year: "1954"})
    @moonrise = Photograph.new({id: "2", name: "Moonrise, Hernandez", artist_id: "2", year: "1941"})
    @twins = Photograph.new({id: "3", name: "Identical Twins, Roselle, New Jersey", artist_id: "3", year: "1967"})
    @monolith = Photograph.new({id: "4", name: "Monolith, The Face of Half Dome", artist_id: "3", year: "1927"})
    @ansel = Artist.new({id: "2", name: "Ansel Adams", born: "1902", died: "1984", country: "United States"})
    @henri = Artist.new({id: "1", name: "Henri Cartier-Bresson", born: "1908", died: "2004", country: "France"})
    @diane = Artist.new({id: "3", name: "Diane Arbus", born: "1923", died: "1971", country: "United States"})
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

    assert_equal [@ansel, @henri], @curator.artists
  end

  def test_it_can_find_a_photograph_by_id
    @curator.add_photograph(@rue)
    @curator.add_photograph(@moonrise)

    assert_equal @rue, @curator.find_photograph_by_id("1")
  end

  def test_it_can_find_an_artist_by_id
    @curator.add_artist(@ansel)
    @curator.add_artist(@henri)

    assert_equal @henri, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@rue)
    @curator.add_photograph(@moonrise)
    @curator.add_photograph(@twins)
    @curator.add_photograph(@monolith)
    @curator.add_artist(@ansel)
    @curator.add_artist(@henri)
    @curator.add_artist(@diane)

    assert_equal [@twins, @monolith], @curator.find_photographs_by_artist(@diane)
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_photograph(@rue)
    @curator.add_photograph(@moonrise)
    @curator.add_photograph(@twins)
    @curator.add_photograph(@monolith)
    @curator.add_artist(@ansel)
    @curator.add_artist(@henri)
    @curator.add_artist(@diane)

    assert_equal [@diane], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_photographs_taken_by_artists_from_a_specific_country
    @curator.add_photograph(@rue)
    @curator.add_photograph(@moonrise)
    @curator.add_photograph(@twins)
    @curator.add_photograph(@monolith)
    @curator.add_artist(@ansel)
    @curator.add_artist(@henri)
    @curator.add_artist(@diane)

    assert_equal [@moonrise, @twins, @monolith], @curator.photographs_taken_by_artists_from("United States")

    assert_empty @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs_from_a_file
    file = "./lib/photo_file.csv"
    @curator.load_photographs(file)

    assert_equal 2, @curator.photographs.length
    assert_instance_of Photograph, @curator.photographs.first
  end
end

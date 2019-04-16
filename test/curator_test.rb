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
    @photo_4_alt = Photograph.new({
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
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
       name: "Walker Evans",
       born: "1903",
       died: "1975",
       country: "United States"
    })
    @artist_5 = Artist.new({
       id: "5",
       name: "Manuel Alvarez Bravo",
       born: "1902",
       died: "2002",
       country: "Mexico"
    })
    @artist_6 = Artist.new({
       id: "6",
       name: "Bill Cunningham",
       born: "1929",
       died: "2016",
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

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal @curator.find_photographs_by_artist(@artist_3),
    [@photo_3, @photo_4]
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal @curator.artists_with_multiple_photographs, [@artist_3]
  end

  def test_it_can_find_photographs_by_artist_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal @curator.photographs_taken_by_artist_from("United States"),
    [@photo_2, @photo_3, @photo_4]
  end

  def test_it_can_load_photographs
    assert_equal @curator.photographs, []
    @curator.load_photographs("./data/photographs.csv")
    assert_equal @curator.photographs[0].id, @photo_1.id
    assert_equal @curator.photographs[1].id, @photo_2.id
    assert_equal @curator.photographs[2].id, @photo_3.id
    assert_equal @curator.photographs[3].id, @photo_4_alt.id
    assert_equal @curator.photographs[0].name, @photo_1.name
    assert_equal @curator.photographs[1].name, @photo_2.name
    assert_equal @curator.photographs[2].name, @photo_3.name
    assert_equal @curator.photographs[3].name, @photo_4_alt.name
    assert_equal @curator.photographs[0].artist_id, @photo_1.artist_id
    assert_equal @curator.photographs[1].artist_id, @photo_2.artist_id
    assert_equal @curator.photographs[2].artist_id, @photo_3.artist_id
    assert_equal @curator.photographs[3].artist_id, @photo_4_alt.artist_id
    assert_equal @curator.photographs[0].year, @photo_1.year
    assert_equal @curator.photographs[1].year, @photo_2.year
    assert_equal @curator.photographs[2].year, @photo_3.year
    assert_equal @curator.photographs[3].year, @photo_4_alt.year
  end

  def test_it_can_load_artists
    assert_equal @curator.artists, []
    @curator.load_artists("./data/artists.csv")
    assert_equal @curator.artists[0].id, @artist_1.id
    assert_equal @curator.artists[1].id, @artist_2.id
    assert_equal @curator.artists[2].id, @artist_3.id
    assert_equal @curator.artists[3].id, @artist_4.id
    assert_equal @curator.artists[4].id, @artist_5.id
    assert_equal @curator.artists[5].id, @artist_6.id
    assert_equal @curator.artists[0].name, @artist_1.name
    assert_equal @curator.artists[1].name, @artist_2.name
    assert_equal @curator.artists[2].name, @artist_3.name
    assert_equal @curator.artists[3].name, @artist_4.name
    assert_equal @curator.artists[4].name, @artist_5.name
    assert_equal @curator.artists[5].name, @artist_6.name
    assert_equal @curator.artists[0].born, @artist_1.born
    assert_equal @curator.artists[1].born, @artist_2.born
    assert_equal @curator.artists[2].born, @artist_3.born
    assert_equal @curator.artists[3].born, @artist_4.born
    assert_equal @curator.artists[4].born, @artist_5.born
    assert_equal @curator.artists[5].born, @artist_6.born
    assert_equal @curator.artists[0].died, @artist_1.died
    assert_equal @curator.artists[1].died, @artist_2.died
    assert_equal @curator.artists[2].died, @artist_3.died
    assert_equal @curator.artists[3].died, @artist_4.died
    assert_equal @curator.artists[4].died, @artist_5.died
    assert_equal @curator.artists[5].died, @artist_6.died
    assert_equal @curator.artists[0].country, @artist_1.country
    assert_equal @curator.artists[1].country, @artist_2.country
    assert_equal @curator.artists[2].country, @artist_3.country
    assert_equal @curator.artists[3].country, @artist_4.country
    assert_equal @curator.artists[4].country, @artist_5.country
    assert_equal @curator.artists[5].country, @artist_6.country
  end

  def test_it_can_find_photos_taken_in_a_range_of_years
    @curator.load_photographs("./data/photographs.csv")
    @curator.load_artists("./data/artists.csv")
    output = @curator.photographs_taken_between(1950..1965)
    expected = [@photo_1, @photo_4_alt]
    assert_equal output[0].id, expected[0].id
    assert_equal output[0].name, expected[0].name
    assert_equal output[0].artist_id, expected[0].artist_id
    assert_equal output[0].year, expected[0].year
    assert_equal output[1].id, expected[1].id
    assert_equal output[1].name, expected[1].name
    assert_equal output[1].artist_id, expected[1].artist_id
    assert_equal output[1].year, expected[1].year
  end

  def test_it_can_list_photographs_by_age_of_the_artist
    @curator.load_photographs("./data/photographs.csv")
    @curator.load_artists("./data/artists.csv")
    expected = {
      44=>"Identical Twins, Roselle, New Jersey",
      39=>"Child with Toy Hand Grenade in Central Park"
    }
    assert_equal @curator.artists_photographs_by_age(@artist_3), expected
  end

end

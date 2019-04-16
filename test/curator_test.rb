require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
require 'csv'
require 'pry'

class CuratorTest < Minitest::Test
  def test_curator_exists
    curator = Curator.new

    expected = Curator
    actual = curator
    assert_instance_of expected, actual
  end

  def test_curator_starts_with_no_photos
    curator = Curator.new

    expected = []
    actual = curator.photographs
    assert_equal expected, actual
  end

  def test_curator_starts_with_no_photos_but_can_add_them
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    expected = []
    actual = curator.photographs
    assert_equal expected, actual

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    expected = [photo_1, photo_2]
    actual = curator.photographs
    assert_equal expected, actual
  end

  def test_curator_starts_with_no_artists_but_can_add_them
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })

    artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })

    expected = []
    actual = curator.artists
    assert_equal expected, actual

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    expected = [artist_1, artist_2]
    actual = curator.artists
    assert_equal expected, actual
  end

  def test_curator_can_find_artist_by_id
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })

    artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    expected = artist_1
    actual = curator.find_artist_by_id("1")
    assert_equal expected, actual
  end

  def test_curator_can_find_photograph_by_id
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })

    artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    expected = photo_2
    actual = curator.find_photograph_by_id("2")
    assert_equal expected, actual
  end

  def test_curator_can_find_photographs_by_artist
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })

    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })

    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })

    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })

    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = [photo_3, photo_4]
    actual = curator.find_photographs_by_artist(artist_3)
    assert_equal expected, actual
  end

  def test_curator_can_find_artists_with_multiple_photos
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })

    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })

    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })

    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })

    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = [artist_3]
    actual = curator.artists_with_multiple_photographs
    assert_equal expected, actual
  end

  def test_curator_can_find_photos_taken_by_artists_from_somewhere
    curator = Curator.new

    photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })

    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })

    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })

    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })

    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = []
    actual = curator.photographs_taken_by_artist_from("Argentina")
    assert_equal expected, actual

    expected = [photo_1]
    actual = curator.photographs_taken_by_artist_from("France")
    assert_equal expected, actual
  end

  def test_curator_can_find_photos_taken_between_years
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')

    expected = 2
    actual = curator.photographs_taken_between(1950..1965).length
    assert_equal expected, actual

    expected = 1954
    actual = curator.photographs_taken_between(1950..1965)[0].year
    assert_equal expected, actual

    expected = 1962
    actual = curator.photographs_taken_between(1950..1965)[1].year
    assert_equal expected, actual

  end

  # def test_curator_can_find_artists_age_at_time_of_photo
  #
  #   curator = Curator.new
  #   curator.load_photographs('./data/photographs.csv')
  #   curator.load_artists('./data/artists.csv')
  #   diane_arbus = find_artist_by_id("3")
  #
  #   expected = 2
  #   actual = curator.artists_photographs_by_age(diane_arbus)
  #   assert_equal expected, actual
  # end


end

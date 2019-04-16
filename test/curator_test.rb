require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
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

end

require 'minitest/autorun'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test
  attr_reader :curator

  def setup
    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, curator
  end

  def test_it_can_add_photographs
    assert_equal [], curator.photographs

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

    assert_equal [photo_1, photo_2], curator.photographs
  end

  def test_it_can_add_artists
    assert_equal [], curator.artists

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

    assert_equal [artist_1, artist_2], curator.artists
  end

  def test_it_can_find_artist_by_id
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

    assert_equal artist_1, curator.find_artist_by_id('1')
  end

  def test_it_can_find_photo_by_id
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

    assert_equal photo_2, curator.find_photograph_by_id('2')
  end

  def test_it_can_find_photographs_by_artist
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

    assert_equal [photo_3, photo_4], curator.find_photographs_by_artist(artist_3)
  end

  def test_it_can_find_artists_with_multiple_photographs
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

    assert_equal [artist_3], curator.artists_with_multiple_photographs
  end

  def test_it_give_all_photos_taken_by_artist_from_country
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

    assert_equal [photo_2, photo_3, photo_4], curator.photographs_taken_by_artist_from("United States")
    assert_equal [], curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_can_load_csv_full_of_artists
    curator.load_artists('artists.csv')

    assert_equal 6, curator.artists.length
    curator.artists.each do |artist|
      assert_instance_of Artist, artist
    end
  end

  def test_it_can_load_csv_full_of_photographers
    curator.load_photographs('photographs.csv')

    assert_equal 4, curator.photographs.length
    curator.photographs.each do |photo|
      assert_instance_of Photograph, photo
    end
  end

  def test_it_can_get_photos_taken_in_range
    curator.load_artists('artists.csv')
    curator.load_photographs('photographs.csv')

    #for testing only
    photographs = {}
    curator.photographs.each do |photo|
      photographs[photo.id.to_i] = photo
    end

    expected = [photographs[1], photographs[4]]

    assert_equal expected, curator.photographs_taken_between(1950..1965)
  end

  def test_it_can_give_artist_photos_by_age
    curator.load_artists('artists.csv')
    curator.load_photographs('photographs.csv')

    diane_arbus = curator.find_artist_by_id("3")
    
    expected = {
      44=>"Identical Twins, Roselle, New Jersey",
      39=>"Child with Toy Hand Grenade in Central Park"
    }

    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end
end

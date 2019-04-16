require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require 'pry'

class ArtistTest < Minitest::Test


  def test_artist_exists_and_has_attributes
    attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist = Artist.new(attributes)

    expected = Artist
    actual = artist
    assert_instance_of expected, actual

    expected = "2"
    actual = artist.id
    assert_equal expected, actual

    expected = "Ansel Adams"
    actual = artist.name
    assert_equal expected, actual

    expected = "1902"
    actual = artist.born
    assert_equal expected, actual

    expected = "1984"
    actual = artist.died
    assert_equal expected, actual

    expected = "United States"
    actual = artist.country
    assert_equal expected, actual
  end

end

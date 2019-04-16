require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'

class ArtistTest < Minitest::Test

  def setup
    @attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist = Artist.new(@attributes)
  end

  def test_artist_class_exists
    assert_instance_of Artist, @artist
  end

  def test_what_artist_id_can_be_equal_to
    assert_equal "2", @artist.id
  end

  def test_what_artist_name_can_be_equal_to
    assert_equal "Ansel Adams", @artist.name
  end

  def test_what_artist_born_date_equal_to
    assert_equal "1902", @artist.born
  end

  def test_what_artist_died_date_equal_to
    assert_equal "1984", @artist.died
  end

  def test_what_artist_country_is_equal_to
    assert_equal "United States", @artist.country
  end
end

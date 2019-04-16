require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require 'pry'

class ArtistTest < MiniTest::Test

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

  def test_artist_exists
    assert_instance_of Artist, @artist
  end

  def test_artist_has_id
    assert_equal "2", @artist.id
  end

  def test_artist_has_name
    assert_equal "Ansel Adams", @artist.name
  end

  def test_artist_born_date
    assert_equal "1902", @artist.born
  end

  def test_artist_died_date
    assert_equal "1984", @artist.died
  end

  def test_artist_country
    assert_equal "United States", @artist.country
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require 'pry'

class TestArtist < Minitest::Test
  def setup
    @attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States" }
  end
  def test_existance
      artist = Artist.new(@attributes)
      assert_instance_of Artist, artist
  end
  def test_it_hash_id
    artist = Artist.new(@attributes)
    assert_equal "2", artist.id
  end
  def test_name
    artist = Artist.new(@attributes)
    assert_equal "Ansel Adams", artist.name
  end
  def test_born
    artist = Artist.new(@attributes)
    assert_equal "1902", artist.born
  end
  def test_died
    artist = Artist.new(@attributes)
    assert_equal "1984", artist.died
  end
  def test_country
    artist = Artist.new(@attributes)
    assert_equal "United States", artist.country
  end
end

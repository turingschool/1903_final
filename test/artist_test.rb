require "./test/test_helper"
require "./lib/artist"

class ArtistTest < Minitest::Test

  def setup
    attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist = Artist.new(attributes)
  end

  def test_it_exists
    assert_instance_of Artist, @artist
  end

  def test_it_has_an_id
    assert_equal @artist.id, "2"
  end

  def test_it_has_a_name
    assert_equal @artist.name, "Ansel Adams"
  end

  def test_it_has_a_year_born
    assert_equal @artist.born, "1902"
  end

  def test_it_has_a_year_died
    assert_equal @artist.died, "1984"
  end

  def test_it_has_a_country
    assert_equal @artist.country, "United States"
  end

end

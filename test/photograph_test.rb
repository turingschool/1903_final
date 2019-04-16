require "./test/test_helper"
require "./lib/photograph"

class PhotographTest < Minitest::Test

  def setup
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }

    @photograph = Photograph.new(attributes)
  end

  def test_it_exists
    assert_instance_of Photograph, @photograph
  end

  def test_it_has_an_id
    assert_equal @photograph.id, "1"
  end

  def test_it_has_a_name
    assert_equal @photograph.name, "Rue Mouffetard, Paris (Boy with Bottles)"
  end

  def test_it_has_an_artist_id
    assert_equal @photograph.artist_id, "4"
  end

  def test_it_has_a_year
    assert_equal @photograph.year, "1954"
  end

end

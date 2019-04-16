require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'

class PhotographTest < Minitest::Test

  def setup
    @attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photograph = Photograph.new(@attributes)
  end

  def test_photograph_class_exists
    assert_instance_of Photograph, @photograph
  end

  def test_what_photograph_id_can_be_equal_to
    assert_equal "1", @photograph.id
  end

  def test_what_photograph_name_can_be_equal_to
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photograph.name
  end

  def test_what_artist_id_can_be_equal_to
    assert_equal "4", @photograph.artist_id
  end

  def test_what_photograph_year_can_be_equal_to
    assert_equal "1954", @photograph.year
  end
end

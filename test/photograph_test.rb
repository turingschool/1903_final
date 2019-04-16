require "./test/test_helper"

class PhotographTest < Minitest::Test

  def setup
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photo = Photograph.new(attributes)
  end

  def test_has_attributes
    assert_equal "1", @photo.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photo.name
    assert_equal "4", @photo.artist_id
    assert_equal "1954", @photo.year
  end


end

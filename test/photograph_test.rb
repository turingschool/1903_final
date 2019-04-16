require 'minitest/autorun'
require 'minitest/emoji'
require './lib/photograph'
# require './lib/artist'

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

  def test_it_has_attributes
    assert_equal "1", @photograph.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photograph.name
    assert_equal "4", @photograph.artist_id
    assert_equal "1954", @photograph.year
  end

end

# pry(main)> attributes = {
#   id: "2",
#   name: "Ansel Adams",
#   born: "1902",
#   died: "1984",
#   country: "United States"
# }
#
# pry(main)> artist = Artist.new(attributes)
# #=> #<Artist:0x00007fc2d0a6c080...>
#
# pry(main)> artist.id
# #=> "2"
#
# pry(main)> artist.name
# #=> "Ansel Adams"
#
# pry(main)> artist.born
# #=> "1902"
#
# pry(main)> artist.died
# #=> "1984"
#
# pry(main)> artist.country
# #=> "United States"

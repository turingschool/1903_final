require 'minitest/autorun'
require './lib/curator'

class UnitTest < MiniTest::Test
  def setup
    @p1 = Photo.new({id: "1", name: "Name1", artist_id: "1", year: "1"})
    @a1 = Artist.new({id: "1", name: "Art1", born: "1", died: "2", country: "Country1"})
    @cur = Curator.new
  end

  def test_inits
    assert_instance_of Photo, @p1
    expect = ["1", "Name1", "1", "1"]
    assert_equal expect, [@p1.id, @p1.name, @p1.artist_id, @p1.year]
    assert_instance_of Artist, @a1
    expect = ["1", "Art1", "1", "2", "Country1"]
    assert_equal expect, [@a1.id, @a1.name, @a1.born, @a1.died, @a1.country]
    assert_instance_of Curator, @cur
    assert_equal [[], []], [@cur.artists, @cur.photos]
  end
end
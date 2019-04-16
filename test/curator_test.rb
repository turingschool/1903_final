require 'minitest/autorun'
require './lib/curator'

class CuratorTest < MiniTest::Test
  def setup
    @p1 = Photo.new({id: "1", name: "Name1", artist_id: "1", year: "5"})
    @p2 = Photo.new({id: "2", name: "Name2", artist_id: "1", year: "10"})
    @p3 = Photo.new({id: "3", name: "Name3", artist_id: "2", year: "15"})
    @a1 = Artist.new({id: "1", name: "Art1", born: "1", died: "2", country: "Country1"})
    @a2 = Artist.new({id: "2", name: "Art2", born: "2", died: "4", country: "Country1"})
    @a3 = Artist.new({id: "3", name: "Art3", born: "3", died: "6", country: "Country3"})
    @cur = Curator.new
    @cur.add_photo(@p1)
    @cur.add_photo(@p2)
    @cur.add_photo(@p3)
    @cur.add_artist(@a1)
    @cur.add_artist(@a2)
    @cur.add_artist(@a3)
    @load = Curator.new
    @load.load_photos('./data/photos.csv')
    @load.load_artists('./data/artists.csv')
  end

  def test_load
    skip
    expect = {"1"=>@a1, "2"=>@a2, "3"=>@a3}
    assert_equal expect, @load.artists
    assert_equal [@p1, @p2, @p3], @load.photos
  end

  def test_add
    assert_equal [@p1, @p2, @p3], @cur.photos
    expect = {"1"=> @a1, "2"=> @a2, "3" => @a3}
    assert_equal expect, @cur.artists
  end

  def test_find_by_ids
    assert_equal @p2, @cur.find_photo_id("2")
    assert_equal @a3, @cur.find_artist_id("3")
  end

  def test_find_by_artist
    assert_equal [@p1, @p2], @cur.find_by_artist(@a1)
  end

  def test_all_multiples
    assert_equal [@a1], @cur.artists_with_multiple_photos
  end

  def test_by_country
    assert_equal [@p1, @p2, @p3], @cur.taken_by_artist_from("Country1")
  end

  def test_taken_between
    assert_equal [@p1, @p2], @cur.photos_taken_between(0..12)
  end

  def test_by_artist_age
    expect = {4=>@p1.name, 9=>@p2.name}
    assert_equal expect, @cur.artist_photos_by_age(@a1)
  end
end
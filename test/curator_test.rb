require "./test/test_helper"

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new

    @photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })

    @photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })

    @photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })

    @photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })

    @artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })

    @artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })

    @artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })


  end

  def test_artists_starts_empty_can_add_to
    assert_equal [], @curator.artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_photopraphs_starts_empty_can_add_to
    assert_equal [], @curator.photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_finds_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_finds_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  #I was unable to figure out how context can add instance variables while still holding variables created outside itself

  def test_finds_artists_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_finds_photograph_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_finds_photographs_by_artists_from_a_given_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [], @curator.photographs_by_artists_from("Argentina")
    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_by_artists_from("United States")
  end

  describe 'it loads the photographs' do

   before(:all) do
     @curator = Curator.new
     @curator.load_photographs
     @curator.load_artists
   end

    def test_loads_photographs
      assert_equal 4, @curator.photographs.length
      @curator.photographs.each{|photo| assert_instance_of Photograph, photo}
    end

    def test_loads_artists
      assert_equal 6, @curator.artists.length
      @curator.artists.each{|artist| assert_instance_of Artist, artist}
    end

    def test_finds_photographs_taken_in_a_range
      ids = @curator.photographs_taken_between(1950..1965).map(&:id)
      assert_equal true,  ids.include?('1')
      assert_equal true,  ids.include?('4')
      assert_equal false,  ids.include?('2')
      assert_equal false,  ids.include?('3')
    end

    def test_returns_artists_photographs_by_age
      diane_arbus = @curator.find_artist_by_id("3")
      expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
      assert_equal expected, @curator.artists_photographs_by_age(diane_arbus)
    end
    
  end

end

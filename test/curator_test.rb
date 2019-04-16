require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < MiniTest::Test
  def setup
    @curator = Curator.new
    @photograph_1 = Photograph.new(id: '1',
                                   name: 'Rue Mouffetard, Paris (Boy with Bottles)',
                                   artist_id: '1',
                                   year: '1954')
    @photograph_2 = Photograph.new(id: '2',
                                   name: 'Moonrise,Hernandez',
                                   artist_id: '2',
                                   year: '1941')
    @photograph_3 = Photograph.new(id: '3',
                                   name: 'Identical Twins, Roselle, New Jersey',
                                   artist_id: '3',
                                   year: '1967')
    @photograph_4 = Photograph.new(id: '4',
                                   name: 'Monolith, The Face of Half Dome',
                                   artist_id: '3',
                                   year: '1927')
    @artist_1 =     Artist.new(id: '1',
                               name: 'Henri Cartier-Bresson',
                               born: '1908',
                               died: '2004',
                               country: 'France')
    @artist_2 =     Artist.new(id: '2',
                               name: 'Ansel Adams',
                               born: '1902',
                               died: '1984',
                               country: 'United States')
    @artist_3 =     Artist.new(id: '3',
                               name: 'Diane Arbus',
                               born: '1923',
                               died: '1971',
                               country: 'United States')
  end

  def test_curator_class_exists
    assert_instance_of Curator, @curator
  end

  def test_curator_has_no_photographs
    assert_equal [], @curator.photographs
  end

  def test_curator_can_add_photographs
    @curator.add_photograph(@photograph_1)
    @curator.add_photograph(@photograph_2)
    @curator.add_photograph(@photograph_3)
    @curator.add_photograph(@photograph_4)
    assert_equal [@photograph_1, @photograph_2, @photograph_3, @photograph_4], @curator.photographs
  end

  def test_curator_has_no_artists
    assert_equal [], @curator.artists
  end

  def test_curator_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal [@artist_1, @artist_2, @artist_3], @curator.artists
  end

  def test_curator_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    assert_equal @artist_1, @curator.find_artist_by_id('1')
  end

  def test_curator_can_find_photograph_by_id
    @curator.add_photograph(@photograph_2)
    assert_equal @photograph_2, @curator.find_photograph_by_id('2')
  end

  def test_find_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photograph_1)
    @curator.add_photograph(@photograph_2)
    @curator.add_photograph(@photograph_3)
    @curator.add_photograph(@photograph_4)
    assert_equal [@photograph_3, @photograph_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_artist_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photograph_1)
    @curator.add_photograph(@photograph_2)
    @curator.add_photograph(@photograph_3)
    @curator.add_photograph(@photograph_4)
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_artist_by_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photograph_1)
    @curator.add_photograph(@photograph_2)
    @curator.add_photograph(@photograph_3)
    @curator.add_photograph(@photograph_4)
    assert_equal [@photograph_2, @photograph_3, @photograph_4], @curator.photographs_taken_by_artist_from('United States')
    assert_equal [], @curator.photographs_taken_by_artist_from('Argentina')
  end
end

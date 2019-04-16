require 'pry'
require 'csv'
class Curator
  attr_reader :photographs, :artists
  def initialize
    # photo = './data/photograph.csv'
    # artist = './data/artists.csv'
    # @pho = CSV.open(photo,headers: true)
    # @arti = CSV.open(artist,headers: true)
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_photograph_by_id(id)
    @photographs.find do |phot|
      phot.id == id
    end
  end

  def find_artist_by_id(id)
    @artists.find do |arti|
      arti.id == id
    end
  end
  def find_photographs_by_artist(artist)
    @photographs.find_all do |ptoto|
      ptoto.artist_id == artist.id
    end
  end
  def artists_with_multiple_photographs
    arr = []
    @artists.each do |art|
      if find_photographs_by_artist(art).count > 1
        arr << art
        end
      end
    arr
  end
  def photographs_taken_by_artist_from(country)
    arr = []
    @artists.each do |art|
      if art.country == country
        arr << art.id
      end
    end
    sa = []
    arr.each do |id|
      @photographs.find_all do |pho|
         sa << pho if pho.artist_id == id
      end
    end
    sa
  end
  # def photographs_taken_between(range)
  #   arr = range.to_a
  #   arrr = []
  #   arr.each do |y|
  #     arrr << y.to_s
  #   end
  #   arrrr = []
  #   arrr.each do |y|
  #   @photographs.find_all do |x|
  #     arrrr << if x.year == y
  #   end
  #   end
  #   arrrr
  # end
end

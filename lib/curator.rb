require './lib/photograph'
require './lib/artist'
require 'csv'

class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end
  
  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find{|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find{|photograph| photograph.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all{|photograph| photograph.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    @artists.each_with_object([]) do |artist, array|
      if find_photographs_by_artist(artist).length > 1
        array << artist
      end
    end
  end

  def photographs_taken_by_artist_from(country)
    @photographs.each_with_object([]) do |photograph, array| 
      artist = find_artist_by_id(photograph.artist_id)
      if artist.country == country
        array << artist unless array.include?(artist)
      end
    end
  end

  def load_photographs(file_path)
    CSV.foreach(file_path, headers:true) do |row|
      photo = Photograph.new({
        id: row['id'],      
        name: row['name'],      
        artist_id: row['artist_id'],      
        year: row['year']})
      add_photograph(photo)
    end
  end

  def load_artists(file_path)
    CSV.foreach(file_path, headers:true) do |row|
      artist = Artist.new({
        id: row['id'],      
        name: row['name'],      
        born: row['born'],      
        died: row['died'],      
        country: row['country']})  
      add_artist(artist)
    end
  end
end
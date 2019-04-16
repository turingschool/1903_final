class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph_object)
    @photographs << photograph_object
  end

  def add_artist(artist_object)
    @artists << artist_object
  end

  def find_artist_by_id(artist_id)
    @artists.find do |artist|
      artist.id == artist_id
    end
  end

  def find_photograph_by_id(photograph_id)
    @photographs.find do |photograph|
      photograph.id == photograph_id
    end
  end

  def find_photographs_by_artist(artist_object)
    @photographs.select do |photograph|
      photograph.artist_id == artist_object.id
    end
  end

  def artists_with_multiple_photographs
    @artists.select do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    artists_grouped_by_country = @artists.select do |artist|
      artist.country == country
    end

    photos_by_artist_from_specified_country = []

    artists_grouped_by_country.each do |artist|
      @photographs.each do |photograph|
        if photograph.artist_id == artist.id
          photos_by_artist_from_specified_country << photograph
        end
      end
    end
    photos_by_artist_from_specified_country
  end

  def photographs_taken_between(range_by_years)
    range = range_by_years.to_a
    @photographs.select do |photograph|
      range.include?(photograph.year.to_i)
    end
  end

end

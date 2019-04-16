

### Iteration 3

Use TDD to update your `Curator` class so that is supports the following methods:

* `find_photographs_by_artist(artist)` - This method takes an `Artist` object and returns an Array of all the Artist's photographs. A `Photograph` is linked to an `Artist` by its `artist_id`
* `artists_with_multiple_photographs` - This method returns an Array of all `Artist`s who have more than one photograph
* `photographs_taken_by_artists_from(string)` - This method takes a String representing a country. It returns an Array of `Photograph`s that were taken by a photographer from that country.

The `Curator` class should now respond to the following interaction pattern:

```ruby
pry(main)> require './lib/photograph'
# => true

pry(main)> require './lib/artist'
# => true

pry(main)> require './lib/curator'
# => true

pry(main)> curator = Curator.new
# => #<Curator:0x00007fabc6c2b680...>

pry(main)> photo_1 = Photograph.new({
     id: "1",      
     name: "Rue Mouffetard, Paris (Boy with Bottles)",      
     artist_id: "1",      
     year: "1954"      
})        
# => #<Photograph:0x00007fabc6933180...>

pry(main)> photo_2 = Photograph.new({    
     id: "2",      
     name: "Moonrise, Hernandez",      
     artist_id: "2",      
     year: "1941"      
})        
# => #<Photograph:0x00007fabc6c28e58...>

pry(main)> photo_3 = Photograph.new({    
     id: "3",      
     name: "Identical Twins, Roselle, New Jersey",      
     artist_id: "3",      
     year: "1967"      
})        
# => #<Photograph:0x00007fabc5bb9ef0...>

pry(main)> photo_4 = Photograph.new({    
     id: "4",      
     name: "Monolith, The Face of Half Dome",      
     artist_id: "3",      
     year: "1927"      
})        
# => #<Photograph:0x00007fabc6b931f0...>

pry(main)> artist_1 = Artist.new({    
     id: "1",      
     name: "Henri Cartier-Bresson",      
     born: "1908",      
     died: "2004",      
     country: "France"      
})        
# => #<Artist:0x00007fabc6a52340...>

pry(main)> artist_2 = Artist.new({    
     id: "2",      
     name: "Ansel Adams",      
     born: "1902",      
     died: "1984",      
     country: "United States"      
})        
# => #<Artist:0x00007fabc6c20870...>

pry(main)> artist_3 = Artist.new({    
     id: "3",      
     name: "Diane Arbus",      
     born: "1923",      
     died: "1971",      
     country: "United States"      
})        
# => #<Artist:0x00007fabc5ba0c70...>

pry(main)> curator.add_artist(artist_1)  

pry(main)> curator.add_artist(artist_2)    

pry(main)> curator.add_artist(artist_3)

pry(main)> curator.add_photograph(photo_1)

pry(main)> curator.add_photograph(photo_2)

pry(main)> curator.add_photograph(photo_3)

pry(main)> curator.add_photograph(photo_4)

pry(main)> curator.find_photographs_by_artist(artist_3)
# => [#<Photograph:0x00007fabc5bb9ef0...>, #<Photograph:0x00007fabc6b931f0...>]

pry(main)> curator.artists_with_multiple_photographs
# => [#<Artist:0x00007fabc5ba0c70...>]

pry(main)> curator.photographs_taken_by_artist_from("United States")
# => [#<Photograph:0x00007fabc6c28e58...>, #<Photograph:0x00007fabc5bb9ef0...>, #<Photograph:0x00007fabc6b931f0...>

pry(main)> curator.photographs_taken_by_artist_from("Argentina")
# => []
```

### Iteration 4

Use TDD to add the following methods to your `Curator` class:

* `load_photographs(file)` - This method takes a path to a CSV file containing photographs and adds them to the `Curator`. You may find the included `FileIO` class useful.
* `load_artists(file)` - This method takes a path to a CSV file containing artists and adds them to the `Curator`. You may find the included `FileIO` class useful.
* `photographs_taken_between(range)` - This method takes a range and returns an array of all photographs with a year that falls in that range.
* `artists_photographs_by_age(artist)`- This method takes an `Artist` object and return a hash where the keys are the Artists age when they took a photograph, and the values are the names of the photographs.

````ruby
pry(main)> require './lib/curator'

pry(main)> curator = Curator.new
#=> #<Curator:0x00007fd98685b2b0...>

pry(main)> curator.load_photographs('./data/photographs.csv')

pry(main)> curator.load_artists('./data/artists.csv')

pry(main)> curator.photographs_taken_between(1950..1965)
#=> [#<Photograph:0x00007fd986254740...>, #<Photograph:0x00007fd986254678...>]

pry(main)> diane_arbus = curator.find_artist_by_id("3")    

pry(main)> curator.artists_photographs_by_age(diane_arbus)
=> {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
```

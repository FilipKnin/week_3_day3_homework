require('pry-byebug')
require_relative('models/album')
require_relative('models/artist')


Album.delete_all()

artist1 = Artist.new({
  'name' => 'Eric Clapton'
  })

artist2 = Artist.new({
  'name' => 'The Rolling Stones'
  })

  artist1.save
  artist2.save

album1 = Album.new({
  'title'     => 'Reptile',
  'genre'     => 'rock',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title'     => 'Sticky Fingers',
  'genre'     => 'rock and roll',
  'artist_id' => artist2.id
  })

  album1.save
  album2.save

  Album.all()
  Artist.all()

  binding.pry
  nil

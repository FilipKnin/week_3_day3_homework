require('pg')

class Album

  attr_accessor(:title, :genre)
  attr_reader(:id, :artist_id)

  def initialize(options) #options is it hash?
    @id = options['id'] if options['id'].to_i()
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "INSERT INTO albums(title, genre, artist_id)
          VALUES
          ($1, $2, $3) RETURNING *"
    values = [@title, @genre, @artist_id]
    db.prepare('save', sql)
    @id = db.exec_prepared('save', values)[0]['id'].to_i()
    db.close()
  end

  def Album.all()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM albums"
    db.prepare('all', sql)
    all_albums = db.exec_prepared('all')
    db.close()
    return all_albums.map{ |album| Album.new(album)}
  end

  def show_an_artist()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * from artists
          WHERE id = $1"
          values = [@artist_id]
    db.prepare("list_all_artists", sql)
    list = db.exec_prepared("list_all_artists", values)
    db.close()
    return list.map { |artist| Artist.new(artist)  }[0]
  end



end

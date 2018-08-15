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

  def update()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "UPDATE albums
          SET (title, genre) =
          (
            $1, $2
            ) WHERE id = $3" #why we need to pass where id?
    values = [@title, @genre, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end


  def delete()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Album.delete_all
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "DELETE FROM albums"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Album.find_album_id(id)
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    db.prepare("find_album_id", sql)
    result = db.exec_prepared("find_album_id", values)
    db.close()
    return result.map { |album| Album.new(album)  }

  end







end

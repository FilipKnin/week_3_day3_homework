require('pg')

class Artist
  attr_accessor :first_name, :last_name
  attr_reader  :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "INSERT INTO artists(name)
          VALUES
          ($1) RETURNING *"
    values = [@name]
    db.prepare('save', sql)
    @id = db.exec_prepared('save', values)[0]['id'].to_i()
    db.close()
  end

  def Artist.all()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM artists"
    db.prepare('all', sql)
    all_artists = db.exec_prepared('all')
    db.close()
    return all_artists.map{ |artist| Artist.new(artist)}
  end

  def all_albums()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    db.prepare('all_albums', sql)
    list = db.exec_prepared('all_albums', values)
    db.close()
    return list.map { |album| Album.new(album) }
  end



end

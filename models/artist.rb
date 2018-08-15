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



end

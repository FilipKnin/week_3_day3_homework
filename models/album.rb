class Album

  attr_accessor(:title, :genre)
  attr_reader(:id, :artist_id)

  def initialize(options) #options is it hash?
    @title = options['title']
    @genre = options['genre']
    @id = options['id'] if options['id'].to_i()
    @artist_id = options['artist_id'].to_i()
  end

end

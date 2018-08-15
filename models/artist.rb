class Artist
  attr_accessor :first_name, :last_name
  attr_reader  :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end
end

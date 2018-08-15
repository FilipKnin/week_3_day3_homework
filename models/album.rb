class Album
  attr_accessor :first_name, :last_name
  attr_reader  :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end
end

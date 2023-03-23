class Movie
  attr_accessor :title,
                :vote_average,
                :id,
                :runtime,
                :genres,
                :overview, 
                :cast

  def initialize(data)
    @id	= data[:id]
    @title        = data[:title]
    @vote_average = data[:vote_average]
    @runtime      = data[:runtime]
    @genres       = data[:genres]
    @overview     = data[:overview]
    @cast         = data[:cast]
  end
end

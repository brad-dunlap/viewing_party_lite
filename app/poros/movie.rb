class Movie
  attr_accessor :title,
              :vote_average

  def initialize(data)
    @title        = data[:title]
    @vote_average = data[:vote_average]
  end
end

# frozen_string_literal: true

class Movie
  attr_accessor :title,
                :vote_average,
                :id

  def initialize(data)
    @id	= data[:id]
    @title        = data[:title]
    @vote_average = data[:vote_average]
  end
end

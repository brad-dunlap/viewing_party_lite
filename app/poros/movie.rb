# frozen_string_literal: true

class Movie
  attr_accessor :title,
                :vote_average,
                :id,
                :runtime,
                :genres,
                :overview

  def initialize(data)
    @id	= data[:id]
    @title        = data[:title]
    @vote_average = data[:vote_average]
    @runtime      = data[:runtime]
    @genres       = data[:genres]
    @overview     = data[:overview]
  end
end

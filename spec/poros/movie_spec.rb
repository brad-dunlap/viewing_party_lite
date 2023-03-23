# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  let(:movie) { described_class.new({ 

      title: 'The Godfather', 
      vote_average: 8.7,
      runtime: 175,
      genres: ['Drama', 'Crime'],
      overview: 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'

    }) }

  it 'exists' do
    expect(movie).to be_a(described_class)
    expect(movie.title).to eq('The Godfather')
    expect(movie.vote_average).to eq(8.7)
    expect(movie.runtime).to eq(175)
    expect(movie.genres).to eq(['Drama', 'Crime'])
    expect(movie.overview).to eq('The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
  end
end

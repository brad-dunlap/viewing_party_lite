# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  before do
    top_movies = File.read('spec/fixtures/top_movies.json')
    stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.4'
        }
      )
      .to_return(status: 200, body: top_movies, headers: {})
  end

  let(:movie) { described_class.new({ title: 'The Godfather' }) }

  it 'exists' do
    expect(movie).to be_a(described_class)
    expect(movie.title).to eq('The Godfather')
  end
end

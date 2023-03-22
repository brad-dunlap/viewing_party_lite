require 'rails_helper'

RSpec.describe Movie do

  before :each do
    json_response = File.read('spec/fixtures/top_movies.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=#{ENV['MOVIE_API_KEY']}")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.4'
        }
      )
      .to_return(status: 200, body: json_response, headers: {})

    @movie = Movie.new(JSON.parse(json_response, symbolize_names: true))
  end

  it 'exists' do
    expect(@movie).to be_a(Movie)
    expect(@movie.title).to eq('The Godfather')
  end
end
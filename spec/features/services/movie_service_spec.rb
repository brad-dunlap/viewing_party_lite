# frozen_string_literal: true

require 'rails_helper'

describe MovieService do
  context 'instance methods' do
    describe '#top_20_movies' do
      it 'returns the top 20 movies' do
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

        movies = described_class.new.top_twenty_movies

        expect(movies).to be_an(Array)
        expect(movies.count).to eq(20)
        expect(movies.first.title).to eq('The Godfather')
        expect(movies.first.vote_average).to eq(8.7)
      end
    end

    describe '#search_results' do
      it 'returns 20 search results' do
        search_results = File.read('spec/fixtures/search_results.json')
        stub_request(:get, 'https://api.themoviedb.org/3/search/movie?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458&query=godfather')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: search_results, headers: {})

        movies = described_class.new.search_results('godfather')

        expect(movies).to be_an(Array)
        expect(movies.count).to eq(20)
        expect(movies.first.title).to eq('Godfather')
        expect(movies.first.vote_average).to eq(8.0)
      end
    end

    describe '#movie_details' do
      it 'returns the details for a movie' do
        movie_details = File.read('spec/fixtures/movie_details.json')
        stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: movie_details, headers: {})

        movie = described_class.new.movie_details(278)

        expect(movie).to be_a(Movie)
        expect(movie.title).to eq("The Shawshank Redemption")
        expect(movie.vote_average.round(1)).to eq(8.7)
        expect(movie.runtime).to eq(142)
      end
    end

    describe '#cast_details' do
      it 'returns the cast for a movie' do

      end
    end

    describe '#reviews' do
      it 'returns all the reviews for a movie' do
        reviews = File.read('spec/fixtures/reviews.json')

        stub_request(:get, 'https://api.themoviedb.org/3/movie/550/reviews?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: reviews, headers: {})

        movies = described_class.new.reviews(550)

        expect(movies).to be_an(Array)
        expect(movies.count).to eq(8)
        expect(movies.first[:author]).to eq('elshaarawy')
      end
    end
  end
end

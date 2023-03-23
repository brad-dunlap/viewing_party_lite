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

        expect(described_class.new.top_twenty_movies).to be_an(Array)
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

        expect(described_class.new.search_results('godfather')).to be_an(Array)
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

        expect(described_class.new.movie_details(278)).to be_a(Movie)
      end
    end

    describe '#cast_details' do
      it 'returns the cast for a movie' do
        cast_details = File.read('spec/fixtures/cast_details.json')
        stub_request(:get, "https://api.themoviedb.org/3/movie/278/credits?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v2.7.4'
          }).
        to_return(status: 200, body: cast_details, headers: {})

        expect(described_class.new.cast_details(278)).to be_an(Array)
      end
    end

    describe '#reviews' do
      it 'returns all the reviews for a movie' do
        reviews = File.read('spec/fixtures/reviews.json')

        stub_request(:get, 'https://api.themoviedb.org/3/movie/278/reviews?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: reviews, headers: {})

        expect(described_class.new.reviews(278)).to be_an(Array)
      end
    end
  end
end

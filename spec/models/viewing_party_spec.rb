# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many :user_viewing_parties }
    it { is_expected.to have_many(:users).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :party_date }
    it { is_expected.to validate_presence_of :party_time }
    it { is_expected.to validate_presence_of :host_id }
    it { is_expected.to validate_presence_of :movie_id }
  end

  describe 'instance methods' do
    it '#party_details' do
      movie_details = File.read('spec/fixtures/movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.7.4'
        }).
      to_return(status: 200, body: movie_details, headers: {})

      bob = User.create!(name: 'Bob', email: 'bob@bob.com')
      movie = Movie.new(JSON.parse(movie_details, symbolize_names: true))
      viewing_party = bob.viewing_parties.create!(movie_id: movie.id, host_id: bob.id, party_date: '2023-06-01', party_time: '12:00',duration: 120)

      expect(viewing_party.party_details).to be_a Hash
      expect(viewing_party.party_details[:title]).to eq('The Shawshank Redemption')
      expect(viewing_party.party_details[:movie_id]).to eq(278)
      expect(viewing_party.party_details[:duration]).to eq("120")
      expect(viewing_party.party_details[:date]).to be_a Date
      expect(viewing_party.party_details[:time]).to be_a Time
      expect(viewing_party.party_details[:host]).to eq('Bob')
      expect(viewing_party.party_details[:attendees]).to eq(['Bob'])
    end
  end
end

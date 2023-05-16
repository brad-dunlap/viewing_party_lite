# frozen_string_literal: true

class ViewingParty < ApplicationRecord
  has_many :user_viewing_parties, dependent: :destroy
  has_many :users, through: :user_viewing_parties

  validates :duration, presence: true
  validates :party_date, presence: true
  validates :party_time, presence: true
  validates :host_id, presence: true
  validates :movie_id, presence: true

  def party_details
    movie = MoviesFacade.new.movie_details(movie_id)
    host = User.find(host_id)
    attendees = users.pluck(:name)

    {
      id:,
      image: "http://image.tmdb.org/t/p/w500/#{movie.poster_path}",
      movie_id:,
      title: movie.title,
      duration:,
      date: party_date,
      time: party_time,
      host: host.name,
      attendees:
    }
  end
end

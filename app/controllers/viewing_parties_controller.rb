# frozen_string_literal: true

class ViewingPartiesController < ApplicationController
  before_action :set_user, only: %i[new create destroy update]
  before_action :require_user, only: %i[new create destroy update]

  def index; end

  def new
    @users = User.all
    @movie = MoviesFacade.new.movie_details(params[:movie_id])
  end

  def create
    movie = MoviesFacade.new.movie_details(params[:movie_id])
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.valid?
      if viewing_party.save
        UserViewingParty.create!(user_id: @user.id, viewing_party_id: viewing_party.id)
        attendees_ids = params[:users]
        attendees_ids.each do |id|
          UserViewingParty.create!(user_id: id, viewing_party_id: viewing_party.id)
        end
        redirect_to '/dashboard'
      end
    else
      flash[:notice] = 'Invalid Input'
      redirect_to "/dashboard/movies/#{movie.id}/viewing-party/new"
    end
  end

  def destroy
    party = ViewingParty.find(params[:party_id])
    party.destroy
    redirect_to '/dashboard'
  end

  private

  def viewing_party_params
    params.permit(:duration, :party_date, :party_time, :host_id, :movie_id)
  end

  def set_user
    @user = current_user
  end
end

class LandingController < ApplicationController
	before_action :require_user, only: [:dashboard]
  def index
    @users = User.all
  end
end

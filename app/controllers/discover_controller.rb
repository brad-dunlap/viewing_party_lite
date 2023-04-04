# frozen_string_literal: true
class DiscoverController < ApplicationController
	before_action :require_user, only: [:show]
  def index
    @user = User.find(params[:user_id])
  end

	def show
		@user = User.find(params[:user_id])
	end
end

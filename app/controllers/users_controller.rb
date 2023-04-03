# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
		@parties = @user.viewing_parties
		@parties_info = @parties.map do |party| 
			party.party_details
		end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
			flash[:success] = "Welcome #{@user.name}!"
      
      redirect_to user_path(@user)
    else
      flash[:notice] = 'Unable to add user'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

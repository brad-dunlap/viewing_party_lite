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
    user = User.new(user_params)
    session[:user_id] = user.id
    if user.save
      session[:user_id] = user.id
      flash[:notice] = 'User successfully created'

      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = user.errors.full_messages.join(',')
      redirect_to '/register'
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.role = 1
      
      if user.login?
        flash[:success] = "Welcome, #{user.name}!"
        redirect_to "/users/#{user.id}"
      elsif user.logout?
        redirect_to root_path
      end

    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

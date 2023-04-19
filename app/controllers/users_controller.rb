# frozen_string_literal: true
class UsersController < ApplicationController
  def show
    @user = current_user
		if @user.present?
			@parties = @user.viewing_parties
			@parties_info = @parties.map do |party| 
				party.party_details
			end
		else
			flash[:notice] = "You must be logged in to view your dashboard"
			redirect_to root_path
		end
  end

  def new
    @user = User.new
  end

  def create
    user_input = user_params
		user_input[:email] = user_input[:email].downcase
		@user = User.new(user_input)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome #{@user.name}!"

			redirect_to '/dashboard'
		else
			flash[:alert] = @user.errors.full_messages.join(', ')
			redirect_to register_path
		end
  end

	def login_form
		@user = User.new
	end

	def login_user
		@user = User.find_by(email: user_params[:email])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			flash[:success] = "Welcome back, #{@user.name}!"
			redirect_to '/dashboard'
		else
			flash[:notice] = 'Incorrect email or password'
			redirect_to login_path
		end
	end

	def logout_user
    session.delete(:user_id)
		flash[:notice] = "You have been successfully logged out"
    redirect_to root_path
  end
	
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

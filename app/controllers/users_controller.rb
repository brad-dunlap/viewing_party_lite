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
    user_input = user_params
		user_input[:email] = user_input[:email].downcase
		@user = User.new(user_input)
		if user_params[:name].blank? || user_params[:email].blank? || user_params[:password].blank? || user_params[:password_confirmation].blank?
			flash[:notice] = 'Please fill in all required information'
			redirect_to register_path
    elsif @user.password != @user.password_confirmation 
			flash[:notice] = 'Passwords do not match'
			redirect_to register_path
		elsif @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome #{@user.name}!"
      redirect_to user_path(@user)
		else
      flash[:notice] = 'Please use a unique email address'
      redirect_to register_path
    end
  end

	def login_form
		@user = User.new
	end

	def login_user
		@user = User.find_by(email: params[:user][:email])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			flash[:success] = "Welcome back, #{@user.name}!"
			redirect_to "/users/#{@user.id}"
		else
			flash[:notice] = 'Incorrect email or password'
			redirect_to login_path
		end
	end

	def logout_user
		User.find(session[:user_id])    
    session[:user_id] = nil         
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

class SessionsController < ApplicationController
  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
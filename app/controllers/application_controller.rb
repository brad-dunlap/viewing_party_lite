# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user
    return unless current_user.nil?

    flash[:notice] = 'You must be logged in to view this page'
    redirect_back(fallback_location: root_path)
  end
end

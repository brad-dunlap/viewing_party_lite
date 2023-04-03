class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

	def require_user
		if session[:user_id] != params[:id].to_i
			flash[:notice] = "You must be logged in to view this page"
			redirect_to root_path
		end
	end
end

class SessionsController < ApplicationController

	skip_before_action :signed_in_user, only: [:new, :create]

	def new
	end

	def create

		user = User.authenticate(params[:username], params[:password])

		if user
			session[:user_id] = user.id
			redirect_to home_index_path, :notice => "Logged in!"
		else
			flash.now.alert = "Invalid username or password"
			render "new"
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end

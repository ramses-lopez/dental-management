class SessionsController < ApplicationController

	skip_before_action :signed_in_user, only: [:new, :create]

	def new
		redirect_to home_index_path if signed_in?
	end

	def create
		user = User.authenticate(params[:username], params[:password])
		if user
			session[:user_id] = user.id
			redirect_to home_index_path, notice: "Bienvenido #{current_user.name}"
		else
			flash.now.alert = 'Usuario o contraseña incorrecta'
			render :new
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end

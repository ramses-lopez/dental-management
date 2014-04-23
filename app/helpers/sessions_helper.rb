module SessionsHelper

	def sign_in(user)
		session[:user_id] = user.id
		session[:role_id] = user.role_id
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def current_user?(user)
		user == current_user
	end

	def current_role
		if @current_role ||= Role.find_by(id: session[:role_id])
			@current_role
		else
			Role.guest
		end
	end

	def current_role?(role)
		role == current_role
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
		redirect_to root_url, notice: I18n.t('text.session.must_sign_in') unless signed_in?
	end

	def sign_out
		reset_session
	end

	def check_permissions
		redirect_to root_url, flash: {error: 'No tiene permisos para ver esta página'} unless current_role.admin?
	end
end

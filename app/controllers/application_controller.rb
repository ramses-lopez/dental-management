class ApplicationController < ActionController::Base
	include SessionsHelper

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.

	protect_from_forgery with: :exception
	before_action :signed_in_user
end

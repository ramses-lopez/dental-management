class HomeController < ApplicationController

	skip_before_action :signed_in_user, only: [:index]

	def index
	end

	def deliver
	end
end

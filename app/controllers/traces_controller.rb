class TracesController < ApplicationController
	def index
		@traces = Trace.paginate(page: params[:page])
	end

	def filter
	end
end

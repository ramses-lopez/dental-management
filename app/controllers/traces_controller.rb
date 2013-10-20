class TracesController < ApplicationController
	def index
		@traces = Trace.all
	end

	def filter
	end
end

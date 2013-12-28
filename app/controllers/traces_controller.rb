class TracesController < ApplicationController
	def index

		@traces = Trace.includes(:item, :user)
		# @traces = @traces.by_user_id(params[:user_id]) unless params[:user_id].blank?
		# @traces = @traces.by_item_id(params[:item_id]) unless params[:item_id].blank?
		# @traces = Trace.within(params[:start_date], params[:end_date]).paginate(page: params[:page]) unless params[:start_date].blank? || params[:end_date].blank?
		@traces = @traces.paginate(page: params[:page])

	end
end



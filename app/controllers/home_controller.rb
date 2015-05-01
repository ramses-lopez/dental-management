class HomeController < ApplicationController
	def index
		@item_number = 25
		@critical_stock = Batch.under_minimum_stock.limit @item_number
	end
end


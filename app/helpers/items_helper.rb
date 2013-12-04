module ItemsHelper

	def stock_level_class(item)
		case
			when item.stock == 0
				'error'
			when item.stock < item.minimum_stock
				'warning'
			else
				''
			end
	end

end

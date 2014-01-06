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

	def units_to_words(units)
 		units == 1 ? "#{units} unidad" : "#{units} unidades"
	end
end

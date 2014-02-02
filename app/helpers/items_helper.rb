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

	def item_format_batches(item)
		unless item.stock == 0
			msg = ""
			item.batches.each do |batch|
				msg += "<li>Lote #{formatted_batch_number} #{batch.formatted_stock}"
				msg += ", expira: #{batch.expiration_date.to_formatted_s}" unless batch.expiration_date.nil?
				msg += "</li>"
			end
			return msg
		else
			"<li>Sin existencia</li>"
		end

	end
end

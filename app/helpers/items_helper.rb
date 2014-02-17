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

	def units_to_words(item, units)
 		units == 1 ? "#{units} #{item.unit_type.name}" : "#{units} #{item.unit_type.name.pluralize(:es)}"
	end

	def item_formatted_batches(item)
		unless item.stock == 0
			msg = "<div><ul>"
			item.batches.each do |batch|
				msg += "<li>#{batch.formatted_stock}, Lote #{batch.formatted_batch_number}"
				msg += ", expira:#{l(batch.expiration_date)}" unless batch.expiration_date.nil?
				msg += "</li>"
			end
			return "#{msg}</ul></div>".html_safe
		else
			"<div><ul><li>Sin existencia</li></ul></div>".html_safe
		end

	end
end

class Item < ActiveRecord::Base
	has_many :invoice_items
	has_many :invoices, through: :invoice_items

	with_options presence: :true do |opt|
		opt.validates :stock, numericality: { only_integer: true }
		opt.validates :label
	end

	def add(quantity = 1)
		self.stock += quantity
	end

	def remove(quantity = 1)
		self.stock -= stock == 0 ? 0 : quantity
	end

	def modify_stock(quantity)
		unless quantity == 0
			case
				when quantity > 0
					self.stock += quantity
				when quantity < 0
					self.stock += stock == 0 ? 0 : quantity
			end

			self.save
		end
	end

end

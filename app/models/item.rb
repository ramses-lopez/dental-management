class Item < ActiveRecord::Base
	has_many :invoice_items
	has_many :invoices, through: :invoice_items
	has_many :traces

	after_save :add_trace #, unless: :new_record?

	#campos para tracing
	attr_accessor :delta, :type, :comment

	default_scope {order :label}

	scope :in_stock, -> {where ('stock > 0')}

	with_options presence: :true do |opt|
		opt.validates :stock, numericality: { only_integer: true }
		opt.validates :label
	end

	def add_stock(quantity = 1)
		self.stock += quantity
	end

	def remove_stock(quantity = 1)
		self.stock -= self.stock == 0 ? 0 : quantity
	end

	def modify_stock(quantity)
		unless quantity == 0
			case
				when quantity > 0
					self.stock += quantity
				when quantity < 0
					self.stock += stock == 0 ? 0 : quantity
			end

			self.save!
		end
	end

	def add_trace
		trace = self.traces.build
		trace.comment = self.comment
		trace.user_id = 1
		trace.value =  self.stock - self.stock_was
		trace.type = trace.value >= 0 ? '+' : '-'
		trace.save!
	end


end

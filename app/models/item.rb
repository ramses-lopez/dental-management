class Item < ActiveRecord::Base
	has_many :invoice_items
	has_many :invoices, through: :invoice_items
	has_many :traces

	after_save :add_trace #, unless: :new_record?

	#campos para tracing
	attr_accessor :delta, :type, :trace_comment, :trace_user

	validates :label, uniqueness: { case_sensitive: false }

	default_scope {order :label}

	scope :in_stock, -> {where ('stock > 0')}
	scope :under_minimum_stock, -> {where("stock <= minimum_stock and stock > 0")}

	#select items.label, count(*) from traces inner join items on traces.item_id = items.id where traces.type = '-' group by items.label having count(*) > 1

	#select items.label, count(*) from traces inner join items on traces.item_id = items.id where traces.type = '-' group by items.label order by count(*) desc

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
		trace.comment = self.trace_comment
		trace.user_id = self.trace_user
		trace.value =  self.stock - self.stock_was
		trace.type = trace.value >= 0 ? '+' : '-'

		trace.save! unless trace.value == 0
	end


end

class Batch < ActiveRecord::Base

	belongs_to :item

	has_many :invoice_items
	has_many :invoices, through: :invoice_items
	has_many :traces

	after_save :add_trace

	#campos para tracing
	attr_accessor :delta, :type, :trace_comment, :trace_user

	scope :in_stock, -> {where ('stock > 0')}
	scope :under_minimum_stock, -> {where("stock <= minimum_stock and stock > 0")}

	with_options presence: :true do |opt|
		opt.validates :stock, numericality: { only_integer: true }
	end

	def add_stock(quantity = 1)
		self.stock += quantity
	end

	def remove_stock(quantity = 1)
		self.stock -= self.stock == 0 ? 0 : quantity
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

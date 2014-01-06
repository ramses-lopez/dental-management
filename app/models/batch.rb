class Batch < ActiveRecord::Base

	belongs_to :item

	has_many :invoice_items
	has_many :invoices, through: :invoice_items
	has_many :traces

	after_save :add_trace

	#campos para tracing
	attr_accessor :delta, :type, :trace_comment, :trace_user

	scope :in_stock, -> {includes(:item).where('stock > 0').order("items.label")}
	scope :under_minimum_stock, -> {includes(:item).where("stock <= minimum_stock and stock >= 0").order("items.label")}

	with_options presence: :true do |opt|
		opt.validates :stock, numericality: { only_integer: true }
	end

	def label
		lbl = "#{self.item.label} [Lote #{self.batch_number}"
		lbl += ", expira: #{self.expiration_date.to_formatted_s(:short_date)}]" unless self.expiration_date.nil?
	end

	def formatted_stock
		stock == 1 ? "#{stock} unidad" : "#{stock} unidades"
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

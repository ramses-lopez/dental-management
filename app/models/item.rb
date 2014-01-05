class Item < ActiveRecord::Base

	has_many :invoice_items
	has_many :batches
	validates :label, uniqueness: { case_sensitive: false }
	before_save lambda{self.label.upcase!}
	default_scope {order :label}

	with_options presence: :true do |opt|
		opt.validates :label
	end

	def stock
		self.batches.nil? ? 0 : self.batches.sum(:stock)
	end

end

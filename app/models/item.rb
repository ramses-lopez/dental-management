class Item < ActiveRecord::Base
	has_many :invoice_items
	has_many :batches
	belongs_to :unit_type

	validates :label, presence: :true, uniqueness: { case_sensitive: false }
	before_save lambda{ self.label = self.label.mb_chars.upcase.to_s }
	default_scope {order :label}
	scope :active, -> {where(active: 1)}
	scope :in_invoices, -> {joins(:invoice_items).distinct}

	# with_options presence: :true do |opt|
	# 	opt.validates :label
	# end

	def formatted_label
		"#{self.label} #{'[inactivo]' unless self.active == 1}"
	end

	def active?
		self.active == 1
	end

	def activate
		self.active = 1
		self.save(validate: false)
	end

	def inactivate
		self.active = 0
		self.save(validate: false)
	end

	def stock
		self.batches.nil? ? 0 : self.batches.sum(:stock)
	end

	def exempt_from_tax?
		self.exempt_from_tax == 1
	end

end

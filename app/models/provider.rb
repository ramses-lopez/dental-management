class Provider < ActiveRecord::Base
	default_scope {order :label}
	has_many :invoices
	has_and_belongs_to_many :products
	before_save lambda{self.label.upcase!}
	scope :with_invoices, -> {joins(:invoices).includes(invoices: :invoice_items).distinct}
end

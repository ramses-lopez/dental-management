class Invoice < ActiveRecord::Base
	has_many :invoice_items
	has_many :items, through: :invoice_items
end

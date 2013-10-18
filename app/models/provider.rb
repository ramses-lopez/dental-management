class Provider < ActiveRecord::Base
	default_scope {order :label}
	has_many :invoices
	has_and_belongs_to_many :products
end

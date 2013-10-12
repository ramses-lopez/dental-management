class Provider < ActiveRecord::Base
	has_many :invoices
	has_and_belongs_to_many :products
end

class Trace < ActiveRecord::Base
	self.inheritance_column = nil

	belongs_to :item
	belongs_to :user
end

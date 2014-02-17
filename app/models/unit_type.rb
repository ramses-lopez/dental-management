class UnitType < ActiveRecord::Base
	has_many :items

	def self.options
		all.map {|o| [o.name, o.id]}
	end
end

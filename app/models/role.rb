class Role < ActiveRecord::Base
	has_many :users

	def self.guest
		Role.new(name: 'guest')
	end

	def admin?
		name == 'administrador'
	end

	def manager?
		name == 'manager'
	end
end

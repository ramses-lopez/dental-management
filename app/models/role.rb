class Role < ActiveRecord::Base
	has_many :users

	def self.guest
		Role.new(name: 'guest')
	end

	def admin?
		name =~ /\Aadministrador\z/i
	end

	def manager?
		name =~ /\Amanager\z/i
	end
end

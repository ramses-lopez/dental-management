class User < ActiveRecord::Base
	has_many :traces
	belongs_to :role

	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :username
	validates_uniqueness_of :username

	def encrypt_password
		if password.present?
			self.password_salt = 'test'
			self.password_hash = self.password_salt + password
		end
	end

	def self.authenticate(username, password)
		user = User.find_by_username(username)

		if user && user.password_hash == user.password_salt + password
			user
		else
			nil
		end
	end

	def admin?
		self.role.admin?
	end

end

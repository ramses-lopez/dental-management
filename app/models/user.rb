class User < ActiveRecord::Base
	has_many :traces
	belongs_to :role
end

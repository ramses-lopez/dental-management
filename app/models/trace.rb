class Trace < ActiveRecord::Base
	self.inheritance_column = nil

	belongs_to :batch
	belongs_to :user

	default_scope {order "traces.created_at desc"}

	scope :by_item_id, ->(item_id) {joins(:batch).where("batches.item_id = ?", item_id)}
	scope :by_user_id, ->(user_id) {where(user_id: user_id)}

	def self.within(start_date, end_date)
		start_date = Date.parse(start_date)
		end_date = Date.parse(end_date)

    	where(created_at: start_date..end_date)
  	end
end

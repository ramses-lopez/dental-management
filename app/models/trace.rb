class Trace < ActiveRecord::Base
	self.inheritance_column = nil

	belongs_to :batch
	belongs_to :user

	default_scope {order "traces.created_at desc"}

	scope :by_item_id, ->(item_id) {joins(:batch).where("batches.item_id = ?", item_id)}
	scope :by_user_id, ->(user_id) {where(user_id: user_id)}

	def self.within(start_date, end_date)
		start_date = DateTime.parse(start_date).start_of_day
		end_date = DateTime.parse(end_date).end_of_day

    	where(created_at: start_date..end_date)
  	end
end

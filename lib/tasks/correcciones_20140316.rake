namespace :db do
	desc "Corrección de varios issues"
	task fix001: :environment do
		ActiveRecord::Base.transaction do
		end
	end
end

def set_items_to_active
end


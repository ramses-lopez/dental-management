namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		reset_db if Rails.env.development?
		#PASSWORD = '123456'
		#COUNTRIES = Carmen::Country.all.collect { |c| c.code }
		#CUSTOMER = Role.customer
		ActiveRecord::Base.transaction do
			create_items
		end
	end
end

def reset_db
	Rake::Task['db:drop'].invoke
	Rake::Task['db:create'].invoke
	Rake::Task['db:migrate'].invoke
	Rake::Task['db:seed'].invoke
end

def create_items
	20.times do |i|
		item = Item.new(
			label: Faker::Commerce.product_name,
			stock: rand(0..200),
			active: rand(0..1)
			)
		item.save!
	end
end



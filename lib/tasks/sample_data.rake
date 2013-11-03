namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		reset_db if Rails.env.development?
		ActiveRecord::Base.transaction do
			create_items
			create_providers
			create_users
		end
	end
end

def reset_db
	Rake::Task['db:drop'].invoke
	Rake::Task['db:create'].invoke
	Rake::Task['db:migrate'].invoke
	Rake::Task['db:seed'].invoke
end

def create_users
	pass = '123456'

	user = User.new(
		name: 'Administrador',
		role_id: 1,
		password_hash: pass,
		password_salt: 'test',
		active: 1,
		username: 'admin'
		)

	user.password = pass
	user.password_confirmation = pass
	user.save!

end

def create_items
	20.times do
		item = Item.new(
			label: Faker::Commerce.product_name,
			stock: 0,
			active: rand(0..1)
			)
		item.save!
	end
end

def create_providers
	10.times do
		provider = Provider.new(
				label: Faker::Company.name,
				phone: Faker::PhoneNumber.phone_number,
				email: Faker::Internet.email,
				website: Faker::Internet.url,
				address: Faker::Address.street_name
			)

		provider.save!

	end
end

def create_invoices

end



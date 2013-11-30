namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		reset_db if Rails.env.development?
		ActiveRecord::Base.transaction do
			create_items
			create_providers
			create_users
			create_invoices
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

	user = User.new(
		name: 'Encargado',
		role_id: 2,
		password_hash: pass,
		password_salt: 'test',
		active: 1,
		username: 'encargado'
	)

	user.password = pass
	user.password_confirmation = pass
	user.save!

end

def create_items
	200.times do
		item = Item.new(
			label: Faker::Commerce.product_name,
			stock: 0,  #rand(1..100),
			minimum_stock: rand(1..20),
			active: 1 #rand(0..1)
			)

		item.save! if item.valid?
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

	10.times do
		invoice = Invoice.new(provider_id: Provider.all.sample.id,
			number: Faker::Code.isbn,
			date: Time.now)

		5.times {invoice.invoice_items << create_invoice_item}

		invoice.save
	end

end


def create_invoice_item

	InvoiceItem.new(
		trace_user: 1,
		item_id: Item.all.sample.id,
		quantity: rand(1..100),
		item_price: rand(100..1000),
		batch_number: rand(1000..20000)
		)


end



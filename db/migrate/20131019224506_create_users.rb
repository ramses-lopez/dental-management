class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.integer :role_id
			t.integer :active
			t.string :name
			t.string :password_hash
			t.string :password_salt
			t.string :username

			t.timestamps
		end
	end
end

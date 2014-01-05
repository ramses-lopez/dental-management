class CreateBatches < ActiveRecord::Migration
	def change
		create_table :batches do |t|
			t.integer :item_id
			t.string :batch_number
			t.date :manufacturing_date
			t.date :expiration_date
			t.integer :stock, default: 0

			t.timestamps
		end

		add_index :batches, [:item_id, :batch_number], unique: true
	end
end

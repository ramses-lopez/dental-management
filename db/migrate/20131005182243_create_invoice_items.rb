class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
    	t.integer :batch_id
		t.integer :invoice_id, null: false
		t.integer :item_id, null: false
		t.integer :quantity, null: false, default: 1
		t.decimal :item_price, precision: 15, scale: 2, default: 0
		t.string :batch_number
		t.datetime :expiration_date

		t.timestamps
    end
  end
end

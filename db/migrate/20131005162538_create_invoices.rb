class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.integer :provider_id, null: false
    	t.string :number, null: false
    	t.datetime :date, null: false
    	#t.decimal :total, default: 0, precision: 15, scale: 2
    	#t.decimal :tax, default: 0, precision: 15, scale: 2

    	t.timestamps
    end
  end
end

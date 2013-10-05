class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.integer :provider_id
    	t.string :number
    	t.date :date
    	t.decimal :total, default: 0, precision: 15, scale: 2
    	t.decimal :tax, default: 0, precision: 15, scale: 2

    	t.timestamps
    end
  end
end

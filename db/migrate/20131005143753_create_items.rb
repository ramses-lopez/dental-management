class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
		t.string :label, null: false
		t.integer :minimum_stock, default: 1
		t.integer :active

		t.timestamps
    end
  end
end

class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|
    	t.integer :user_id
    	t.integer :item_id
    	t.integer :value
    	t.string :type

		t.timestamps
    end
  end
end

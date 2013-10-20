class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|
    	t.integer :user_id
    	t.integer :item_id
    	t.integer :value
    	t.string :type
    	t.string :comment

		t.timestamps
    end
  end
end

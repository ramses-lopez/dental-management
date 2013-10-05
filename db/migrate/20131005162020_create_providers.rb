class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
    	t.string :label
    	t.string :phone
    	t.string :email
    	t.string :website
    	t.text :address
		t.timestamps
    end
  end
end

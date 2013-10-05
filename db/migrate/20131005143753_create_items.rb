class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :label, null: false
      t.integer :stock, default: 0, null: false
      t.integer :active

      t.timestamps
    end
  end
end

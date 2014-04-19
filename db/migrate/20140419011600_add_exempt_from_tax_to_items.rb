class AddExemptFromTaxToItems < ActiveRecord::Migration
  def change
    add_column :items, :exempt_from_tax, :integer, default: 1
  end
end

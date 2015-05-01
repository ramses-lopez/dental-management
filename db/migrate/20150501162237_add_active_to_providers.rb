class AddActiveToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :active, :integer, default: 1
  end
end

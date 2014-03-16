class SetItemActiveDefault < ActiveRecord::Migration
  def change
  	change_column :items, :active, :integer, default: 1

  	Item.all.each do |i|
  		i.active = 1
  		i.save
  	end
  end
end

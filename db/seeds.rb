# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def clear_and_reset(classname)
	classname.classify.constantize.destroy_all
	ActiveRecord::Base.connection.reset_pk_sequence!(classname.tableize)
end

ActiveRecord::Base.transaction do

	clear_and_reset('Role')
	Role.create!([
		{ name: "administrador"},
		{ name: "manager"}
	])

end
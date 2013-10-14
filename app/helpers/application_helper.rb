module ApplicationHelper

	def full_title(page_title)
		base_title = "Dento Spa Laser"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def link_to_add_fields(name, f, association, html_class = '')
		id, fields = add_fields name, f, association
		link_to(name, '#', class: "add_fields #{html_class}", data: {container: "##{association.to_s}_container" , id: id, fields: fields.gsub("\n", "")})
	end

	def link_to_remove_fields(name, f, html_class = '')
		f.hidden_field(:_destroy) + link_to(name, '#', class: "remove_fields #{html_class}")
	end

	def select_to_add_fields(name, f, association, options)
		id, fields = add_fields name, f, association
		select_tag name, options, class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
	end

	def get_grouped_options(item_collection)
		hsh = {}
		item_collection.map do |i|
			key = i.label[0].to_sym
			hsh[key] = [] if hsh[key].nil?
			hsh[key] << [i.label, i.id]
		end
		hsh
	end

	private
		def add_fields(name, f, association)
			new_object = f.object.send(association).klass.new
			id = new_object.object_id
			fields = f.fields_for(association, new_object, child_index: id) do |builder|
				render(association.to_s.pluralize + "/fields", f: builder)
			end
			return id, fields
		end
	#end private
end

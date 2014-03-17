namespace :fix do
	desc "Corrección de varios issues"
	task fix20140316: :environment do
		ActiveRecord::Base.transaction do
			eliminar_elementos_sin_item
		end
	end
end

def eliminar_elementos_sin_item
	puts "eliminar_elementos_sin_item\n"
	#eliminar invoices, batches e traces de items eliminados
	a = InvoiceItem.select {|i| i.batch.item.nil?}
	log = "invoice_items sin item: #{a.size}\n"
	puts "A eliminar #{a.inspect}"
	count = 0
	a.each do |i|
		b = i.batch
		b.traces.destroy_all unless b.traces.nil?
		b.destroy unless b.nil?
		i.destroy
		count += 1
	end

	puts "Eliminados #{count}:\n#{log}\n"
end


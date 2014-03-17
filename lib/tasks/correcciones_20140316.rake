namespace :fix do
	desc "Corrección de varios issues"
	task fix20140316: :environment do
		ActiveRecord::Base.transaction do
			eliminar_elementos_sin_item
			crear_batches_para_invoices
		end
	end
end

#eliminar invoices, batches e traces de items eliminados
def eliminar_elementos_sin_item
	puts "eliminar_elementos_sin_item\n"
	a = InvoiceItem.select {|i| i.batch.item.nil?}
	log = "invoice_items sin item: #{a.size}\n"
	puts "A eliminar #{a.inspect}"
	count = 0
	a.each do |i|
		b = i.batch
		b.traces.destroy_all unless b.traces.nil?
		i.destroy
		count += 1
	end

	puts "Eliminados #{count}:\n#{log}\n"
end

#completa los batches que no se crearon por el error en la actualización de las facturas
def crear_batches_para_invoices
	puts "crear_batches_para_invoices\n"

	count = 0

	#obtengo los traces negativos
	traces = Trace.where(type:'-')

	batches_entregas = traces.map {|t| [t.batch.batch_number, t.batch.item_id, t.value, t.comment, t.user_id] }
	#puts batches_entregas

	Batch.destroy_all
	Trace.destroy_all

	InvoiceItem.all.each do |i|
		batch = Batch.find_by(item_id: i.item_id, batch_number: i.batch_number.to_s)

		if batch.nil?
			batch = Batch.create!(
				item_id: i.item_id,
				batch_number: i.batch_number,
				expiration_date: i.expiration_date,
				stock: i.quantity,
				trace_comment: "Creación de factura #{i.invoice.number}",
				trace_user: i.trace_user,
				)
			i.batch_id = batch.id
			i.save
		else
			batch.expiration_date = i.expiration_date
			batch.stock = batch.add_stock(i.quantity)
			batch.trace_comment = "Actualización de factura #{i.invoice.number}"
			batch.trace_user = i.trace_user
			batch.save
			i.batch = batch
			i.save
		end

		count += 1
	end

	#ahora se restan los entregados
	batches_entregas.each do |b|
		batch = Batch.find_by(item_id: b[1], batch_number: b[0].to_s)

		unless batch.nil?
			batch.trace_comment = b[3]
			batch.trace_user = b[4]
			batch.remove_stock(-1*b[2])
			batch.save
		else
			puts "No encontrado item:#{b[1]} batch_number:#{b[0]}"
		end
	end

	puts "creados #{count} batches\n"
end


namespace :fix do
	desc "Corrección de invoice items con batch = nil"
	task fix20140403: :environment do
		ActiveRecord::Base.transaction do
			eliminar_invoice_items_con_batch_nil
		end
	end
end

def corregir_invoice_items_con_batch_en_nil
	InvoiceItem.where(batch_id: nil).each do |i|
		batch = Batch.find_by(item_id: i.item_id, batch_number: i.batch_number)
		i.update_column(:batch_id, batch.id) # es necesario brincarse el update callback
	end
end

def eliminar_invoice_items_con_batch_nil
	ii_count = 0
	invoice_count = 0
	deleted_invoices = 0

	InvoiceItem.where(batch_id: nil).each do |i|
		invoice = i.invoice
		invoice_count += 1
		ii_count += 1 if i.destroy

		if invoice.invoice_items.size == 0
			deleted_invoices += 1 if invoice.destroy
		end
	end

	puts "Se eliminaron #{ii_count} invoice_items en #{invoice_count} facturas afectadas, y se eliminaron #{deleted_invoices} facturas vacías"
end

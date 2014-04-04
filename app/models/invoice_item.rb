class InvoiceItem < ActiveRecord::Base

	belongs_to :invoice
	belongs_to :batch
	belongs_to :item

	attr_accessor :trace_comment, :trace_user

	after_create { create_batch }
	after_update { update_batch }

	before_destroy do
		batch = self.batch

		unless batch.nil?
			comment = "Actualización de factura #{self.invoice.number}"
			batch.remove_stock(self.quantity)
			batch.trace_user = self.trace_user
			batch.trace_comment = comment

			batch.save
		end
	end

	def create_batch
		comment = "Creación de factura #{self.invoice.number}"

		batch = Batch.find_by(item_id: self.item_id, batch_number: self.batch_number.to_s)

		if batch.nil?
			batch = Batch.new(
				item_id: self.item_id,
				batch_number: self.batch_number,
				expiration_date: self.expiration_date,
				stock: self.quantity,
				trace_comment: comment,
				trace_user: self.trace_user,
				)
			batch.save
		else
			batch.expiration_date = self.expiration_date
			batch.stock += self.quantity
			batch.trace_comment = comment
			batch.trace_user = self.trace_user
			self.batch = batch
			self.batch.save
		end

		self.update_column(:batch_id, batch.id) # es necesario brincarse el update callback
	end

	def update_batch
		#FIXME: DEPRECATION WARNING: Passing options to #find is deprecated. Please build a scope and then call #find on it. (called from update_invoice_item at /home/ramses/projects/dento-spa/app/models/invoice_item.rb:45)
		#FIXME: no estoy seguro que esta causando un readonlyrecord error aqui. por alguna razon rails esta marcando el objeto como readonly
		batch = Batch.find(self.batch.id, readonly: false)

		batch.expiration_date = self.expiration_date
		comment = self.trace_comment.blank? ? "Actualización de factura #{self.invoice.number}" : self.trace_comment

		case
			when self.batch_number_changed?
				#TODO: Se estan grabando dos traces en este caso, revisar
				#cuando cambia el numero de lote, se debe restar el monto del numero de lote actual, y sumarlo al lote nuevo
				batch.remove_stock(self.quantity_was)
				batch.trace_comment = comment
				batch.trace_user = self.trace_user
				batch.save

				batch.destroy if batch.stock == 0

				new_batch = Batch.where(item_id: self.item_id, batch_number: self.batch_number.to_s).first_or_create
				new_batch.item_id = self.item_id
				new_batch.batch_number = self.batch_number
				new_batch.expiration_date = self.expiration_date
				new_batch.trace_comment = comment
				new_batch.trace_user = self.trace_user
				new_batch.stock += self.quantity
				self.batch = new_batch
				new_batch.save

			when self.quantity_changed?
				batch.remove_stock(self.quantity_was)
				batch.trace_comment = comment
				batch.trace_user = self.trace_user
				batch.add_stock(self.quantity)
				batch.save
		end
	end

end

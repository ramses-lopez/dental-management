class InvoiceItem < ActiveRecord::Base

	belongs_to :invoice
	belongs_to :batch
	belongs_to :item

	attr_accessor :trace_comment, :trace_user

	before_save lambda{new_record? ? create_invoice_item : update_invoice_item}

	#TODO: cuando se crea la factura no se esta guardando el comentario para el trace
	def create_invoice_item
		comment = trace_comment.blank? ? "Creación de factura #{self.invoice.number}" : self.trace_comment

		self.batch = Batch.where(item_id: self.item_id, batch_number: self.batch_number.to_s).first_or_create do |_b|
			_b.item_id = self.item_id
			_b.batch_number = self.batch_number
			_b.expiration_date = self.expiration_date
			_b.stock += self.quantity
			_b.trace_comment = self.trace_comment
			_b.trace_user = self.trace_user
		end
	end

	def update_invoice_item
		batch = self.batch
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

			when self.destroyed?
				batch.remove_stock(self.quantity)
				batch.trace_user = self.trace_user
				batch.save
		end
	end

end

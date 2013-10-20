class InvoiceItem < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :item

	before_save :update_stock

	def update_stock

		logger.debug "before_save"

		#Se cambio el material
		if self.item_id_changed?

			old_item = Item.find self.item_id_was

			logger.debug "Stock Item Anterior #{old_item.label} (#{old_item.stock})"

			#elimino el monto anterior y se suma el nuevo monto
			old_item.stock -= self.quantity_was
			#se agrega la cantidad al nuevo item

			old_item.save

			logger.debug "Stock Item Anterior Actualizado #{old_item.label} (#{old_item.stock})"
			logger.debug "Nuevo Item #{self.item.label}(#{self.item.stock})"

			self.item.stock += self.quantity

			logger.debug "Nuevo Item #{self.item.label}(#{self.item.stock})"

		elsif self.quantity_changed?
			logger.debug "quantity_changed"

			logger.debug "stock #{self.item.stock}"

			self.item.stock -= self.quantity_was
			self.item.stock += self.quantity

			logger.debug "stock #{self.item.stock}"

		elsif self.destroyed?
			logger.debug "self.destroyed"
			logger.debug "stock #{self.item.stock}"

			self.item.stock -= self.quantity

			logger.debug "stock #{self.item.stock}"
		end

		self.item.save
	end
end

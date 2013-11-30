class InvoiceItem < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :item

	attr_accessor :trace_comment, :trace_user

	before_save :update_stock, unless: :new_record?
	before_save :add_stock, if: :new_record?

	def update_stock

		comment = "Actualización Factura #{self.invoice.number}"

		if self.item_id_changed?

			old_item = Item.find self.item_id_was
			old_item.remove_stock self.quantity_was
			old_item.trace_comment = comment
			old_item.save!

			self.item.add_stock self.quantity

		elsif self.quantity_changed?
			self.item.remove_stock self.quantity_was
			self.item.add_stock self.quantity

		elsif self.destroyed?
			self.item.remove_stock self.quantity
		end

		self.item.trace_user = trace_user
		self.item.trace_comment = comment
		self.item.save!

	end

	def add_stock
		self.item.trace_comment =  self.trace_comment.blank? ? "Inserción de #{Item.model_name.human} #{self.item.label}" : self.trace_comment
		self.item.trace_user = self.trace_user
		self.item.add_stock self.quantity
		self.item.save!
	end

end

class HomeController < ApplicationController
	def index
	end

	def report1
		if params[:provider_id]
			@invoice_items = InvoiceItem.joins(:invoice).where("invoices.provider_id = ?", params[:provider_id])
		else
			@invoice_items = nil
		end
	end

	def report2
		if params[:item_id]
			@invoice_items = InvoiceItem.joins(invoice: :provider).where("invoice_items.item_id = ?", params[:item_id])
		else
			@invoice_items = nil
		end
	end
end


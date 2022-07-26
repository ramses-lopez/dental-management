class InvoicesController < ApplicationController
	before_action :check_permissions
	before_action :set_invoice, only: [:show, :edit, :update, :destroy]

	# GET /invoices
	# GET /invoices.json
	def index
		@invoices = Invoice.includes(:provider)
		@invoices = @invoices.paginate(page: params[:page])
	end

	# GET /invoices/1
	# GET /invoices/1.json
	def show

		#calculo del total, subtotal e impuesto
		@subtotal = 0
		@tax_total = 0
		tax = 0.12

		@invoice.invoice_items.each do |i|
			@subtotal += i.quantity * i.item_price
			@tax_total += (i.quantity * i.item_price)*tax unless i.item.exempt_from_tax?
		end

		@total = @subtotal+@tax_total

		@subtotal = ActionController::Base.helpers.number_to_currency(@subtotal)
		@tax_total = ActionController::Base.helpers.number_to_currency(@tax_total)
		@total = ActionController::Base.helpers.number_to_currency(@total)

	end

	# GET /invoices/new
	def new
		@invoice = Invoice.new
		@invoice.invoice_items << InvoiceItem.new
	end

	# GET /invoices/1/edit
	def edit
	end

	# POST /invoices
	# POST /invoices.json
	def create
		@invoice = Invoice.new(invoice_params)

		respond_to do |format|
			if @invoice.save
				format.html { redirect_to @invoice, flash: {success: 'Factura creada'} }
				format.json { render action: 'show', status: :created, location: @invoice }
			else
				format.html { render action: 'new' }
				format.json { render json: @invoice.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /invoices/1
	# PATCH/PUT /invoices/1.json
	def update
		respond_to do |format|
			if @invoice.update(invoice_params)
				format.html { redirect_to @invoice, flash: {success: "#{Invoice.model_name.human} actualizada"} }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @invoice.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /invoices/1
	# DELETE /invoices/1.json
	def destroy
		@invoice.invoice_items.each do |ii|
			ii.trace_user = current_user
			ii.save
		end

		@invoice.destroy

		respond_to do |format|
			format.html { redirect_to invoices_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_invoice
		begin
			@invoice = Invoice.includes(invoice_items: :item).find(params[:id])
		rescue ActiveRecord::RecordNotFound => e
			redirect_to invoices_path, error: "No se encontró la #{Invoice.model_name.human} con ID #{params[:id]}"
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def invoice_params
		params.require(:invoice).permit(:provider_id, :number, :date, :tax, :total,
			invoice_items_attributes: [:id, :item_id, :quantity, :item_price, :batch_number, :expiration_date, :_destroy, :trace_comment, :trace_user])
	end
end
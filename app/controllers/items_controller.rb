class ItemsController < ApplicationController

	skip_before_action :signed_in_user, only: [:current_stock]
	before_action :set_item, only: [:show, :edit, :update, :destroy]

	# GET /items
	# GET /items.json
	def index
		@items = Item.all
		@items = @items.where(id: params[:item_id]) unless params[:item_id].blank?
		@items = @items.paginate(page: params[:page])
	end

	# GET /items/1
	# GET /items/1.json
	def show
	end

	# GET /items/new
	def new
		@item = Item.new
	end

	# GET /items/1/edit
	def edit
	end

	# POST /items
	# POST /items.json
	def create
		@item = Item.new(item_params)

		respond_to do |format|
			if @item.save
				format.html { redirect_to items_path, notice: "#{Item.model_name.human} creado." }
				format.json { render action: 'show', status: :created, location: @item }
			else
				format.html { render action: 'new' }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /items/1
	# PATCH/PUT /items/1.json
	def update
		respond_to do |format|
			if @item.update(item_params)
				format.html { redirect_to items_path, notice: "#{Item.model_name.human} actualizado." }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /items/1
	# DELETE /items/1.json
	def destroy
		@item.destroy
		respond_to do |format|
			format.html { redirect_to items_url }
			format.json { head :no_content }
		end
	end

	def deliver
		@batches = Batch.joins(:item).includes(:item).in_stock.order("items.label")
		@batches = @batches.where(item_id: params[:item_id]) unless params[:item_id].blank?
		@batches = @batches.paginate(page: params[:page])
	end

	def deliver_stock
		batches_to_update = Batch.find params[:item_ids].keys
		batches_to_update.each do |batch|
			type = params[:item_ids][batch.id.to_s]['type']
			comment = params[:item_ids][batch.id.to_s]['comment']
			delta = params[:item_ids][batch.id.to_s]['delta'].to_i

			if delta > 0
				delta *= -1 if type == '-'
				batch.stock += delta
				batch.trace_comment = comment
				batch.trace_user = current_user.id
				batch.save
			end
		end
		redirect_to items_deliver_path, flash: {success: 'Inventario actualizado'}
	end

	def update_inventory
		@batches = Batch.joins(:item).includes(:item).order("items.label").paginate(page: params[:page])
	end

	def update_stock
		batch_to_update = Batch.find params[:item_ids].keys
		batch_to_update.each do |batch|
			comment = params[:item_ids][batch.id.to_s]['comment']
			new_quantity = params[:item_ids][batch.id.to_s]['new_quantity'].to_i

			unless new_quantity == batch.stock
				batch.stock = new_quantity
				batch.trace_comment = comment
				batch.trace_user = current_user.id
				batch.save
			end
		end

		redirect_to items_update_inventory_path, flash: {success: 'Inventario actualizado'}
	end

	def current_stock
		@items = Batch.joins(:item).includes(:item).in_stock.order("items.label")
		@items = @items.where(item_id: params[:item_id]) unless params[:item_id].blank?
		@items = @items.paginate(page: params[:page])
		#@items = Batch.in_stock.paginate(page: params[:page])
	end

	def under_minimum_stock
		@items = Batch.under_minimum_stock.paginate(page: params[:page])
	end

	def by_provider
		if params[:provider_id]
			@invoice_items = InvoiceItem.includes(:item, :invoice).joins(invoice: :invoice_items)
				.where("invoices.provider_id = ?", params[:provider_id])
				.distinct.order(:updated_at)
				.paginate(page: params[:page])
		else
			@invoice_items = nil
		end
	end

	def by_item
		if params[:item_id]
			@invoice_items = InvoiceItem.joins(invoice: :provider).where("invoice_items.item_id = ?", params[:item_id]).paginate(page: params[:page])
		else
			@invoice_items = []
		end
	end

	def expiring_soon
		@items = Batch.expiring_soon.paginate(page: params[:page])
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_item
			@item = Item.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def item_params
			params.require(:item).permit(:label, :stock, :minimum_stock, :unit_type_id)
		end
end

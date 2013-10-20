class ItemsController < ApplicationController
	before_action :set_item, only: [:show, :edit, :update, :destroy]

	# GET /items
	# GET /items.json
	def index
		@items = Item.all
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
				format.html { redirect_to @item, notice: 'Item was successfully created.' }
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
				format.html { redirect_to @item, notice: 'Item was successfully updated.' }
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
		@items = Item.in_stock
	end

	def update_stock

		items_to_update = Item.find params[:item_ids].keys
		items_to_update.each do |item|

			type = params[:item_ids][item.id.to_s]['type']
			delta = params[:item_ids][item.id.to_s]['delta'].to_i

			if delta > 0
				delta *= -1 if type == '-'

				item.stock += delta
				item.save

				trace = Trace.new(user_id:1, item_id: item.id, value: delta, type: type)
				trace.save
			end

		end

		redirect_to items_deliver_path, notice: 'Inventario actualizado'
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_item
			@item = Item.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def item_params
			params.require(:item).permit(:label, :stock)
		end
end

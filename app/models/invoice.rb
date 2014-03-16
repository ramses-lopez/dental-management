class Invoice < ActiveRecord::Base
	belongs_to :provider

	has_many :invoice_items, dependent: :destroy
	accepts_nested_attributes_for :invoice_items, allow_destroy: true

	has_many :batches, through: :invoice_items
	accepts_nested_attributes_for :batches, allow_destroy: true

	#TODO: hay que validar que manden al menos un invoice item y por ende un batch
	validates :provider_id, :number, :date, presence: true

end

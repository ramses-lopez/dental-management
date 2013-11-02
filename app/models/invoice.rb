class Invoice < ActiveRecord::Base
	belongs_to :provider
	has_many :invoice_items, dependent: :destroy
	has_many :items, through: :invoice_items
	accepts_nested_attributes_for :invoice_items, allow_destroy: true
	#hay que validar que manden al menos un invoice item

	validates :provider_id, :number, :date, presence: true


end

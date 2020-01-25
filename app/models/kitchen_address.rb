class KitchenAddress < ApplicationRecord
  belongs_to :kitchen, optional: false

  validates :address, :city, :state, :zip_code, presence: true
end

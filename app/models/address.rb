class Address < ApplicationRecord
    belongs_to :user

    validates :address, :city, :state, :zip_code, presence: true
end

class Order < ApplicationRecord
    belongs_to :user
    has_many :order_foods, dependent: :destroy 
    accepts_nested_attributes_for :order_foods, :allow_destroy => true
end

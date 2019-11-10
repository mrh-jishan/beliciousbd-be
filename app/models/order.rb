class Order < ApplicationRecord
    belongs_to :user
    has_many :order_foods, dependent: :destroy 
    accepts_nested_attributes_for :order_foods, :allow_destroy => true

    after_create :update_cart_processed_status



    def update_cart_processed_status
        
    end
end

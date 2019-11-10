class Order < ApplicationRecord
    belongs_to :user
    has_many :order_foods, dependent: :destroy 
    accepts_nested_attributes_for :order_foods, :allow_destroy => true

    after_create :update_cart_processed_status



    def update_cart_processed_status
        # self.order_foods.each |order_food| do
        #     order_food.order_cart.processed = true
        # end
        self.order_foods.each { |order_food| order_food.order_cart.update_attributes({ processed: true }) }
    end
end

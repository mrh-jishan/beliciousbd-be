class Order < ApplicationRecord
    belongs_to :user
    has_many :order_foods, dependent: :destroy 
    accepts_nested_attributes_for :order_foods, :allow_destroy => true

    validates :status, :total_price, presence: true

    after_create :update_cart_processed_status

    def update_order_status(status)
        self.status = $ORDER_STATUS[status.to_sym]
        self.save
    end

    def update_cart_processed_status
        self.order_foods.each { |order_food| order_food.order_cart.update_attributes({ processed: true }) }
    end
end

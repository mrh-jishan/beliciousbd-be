class OrderFood < ApplicationRecord
    belongs_to :food
    belongs_to :order_cart
    belongs_to :order, optional: true    
end

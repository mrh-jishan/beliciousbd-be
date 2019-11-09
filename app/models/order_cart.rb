class OrderCart < ApplicationRecord
    belongs_to :customer, class_name: "User"
    belongs_to :chef, class_name: "User"
    belongs_to :food
    
end

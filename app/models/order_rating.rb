class OrderRating < ApplicationRecord
    belongs_to :order, optional: true
    belongs_to :user, optional: true

    validates :rating, presence: true
end

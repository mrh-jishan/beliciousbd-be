class Ingredient < ApplicationRecord
    belongs_to :food, optional: true

    validates :name, presence: true
end

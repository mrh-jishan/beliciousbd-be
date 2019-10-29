class Food < ApplicationRecord

    belongs_to :kitchen

    has_many :ingredients
    accepts_nested_attributes_for :ingredients, :allow_destroy => true

    validates :name, :category, :description, :reciepe, presence: true

end

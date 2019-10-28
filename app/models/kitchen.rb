class Kitchen < ApplicationRecord
    belongs_to :user

    validates :name, :title, :description, presence: true
end

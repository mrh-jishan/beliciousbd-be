class Kitchen < ApplicationRecord
    belongs_to :user

    has_many :tags, dependent: :destroy
    accepts_nested_attributes_for :tags, :allow_destroy => true

    has_many :foods

    validates :name, :title, :description, presence: true
end

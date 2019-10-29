class Kitchen < ApplicationRecord
    belongs_to :user
    
    has_many :tags
    accepts_nested_attributes_for :tags, :allow_destroy => true

    validates :name, :title, :description, presence: true
end

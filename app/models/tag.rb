class Tag < ApplicationRecord
  belongs_to :kitchen, optional: true

  validates :name, presence: true
end

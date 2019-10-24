class User < ApplicationRecord
  has_one :address
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, :gender, presence: true
  validates :password,length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end

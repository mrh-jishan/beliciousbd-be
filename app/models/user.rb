class User < ApplicationRecord
  has_one :address
  has_secure_password

  # send email 
  before_create :confirmation_token

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, :gender, presence: true
  validates :password,length: { minimum: 6 }, if: -> { new_record? || !password.nil? }


  private 

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end

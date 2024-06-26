class User < ApplicationRecord
  has_one :address
  has_many :kitchens

  # order_cart
  has_many :customer_order_carts, class_name: "OrderCart", foreign_key: "customer_id"
  has_many :chef_order_carts, class_name: "OrderCart", foreign_key: "chef_id"

  has_many :orders
  has_many :order_ratings

  has_secure_password
  # user role
  enum role: {:admin => "admin", :customer => "customer", :chef => "chef"}

  # send email 
  before_create :confirmation_token
  after_create :send_email_confirmation_mail

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :first_name, :last_name, :gender, :role, presence: true
  validates :password, length: {minimum: 6}, if: -> { new_record? || !password.nil? }

  # downcase email before save
  before_save { email.downcase! }

  def email_activate
    raise StandardError.new("Sorry! Email already verified.") if self.email_confirmed
    self.email_confirmed = true
    self.save
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
  end

  def send_email_confirmation_mail
    UserMailer.registration_confirmation(self).deliver
  end
end

class User < ApplicationRecord
  has_one :address
  has_secure_password
end

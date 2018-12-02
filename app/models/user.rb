class User < ApplicationRecord
  validates :name, presence: true, length: { in: 1..20 }
  validates :email, presence: true, length: { in: 1..20 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  has_secure_password
  validates :password, length: { in: 6..20 }
  before_validation { email.downcase! }
end
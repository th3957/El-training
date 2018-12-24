class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  before_save :admin_presence?

  has_many :tasks, dependent: :destroy

  enum role: { role_common: 0, role_admin: 1 }

  validates :name, presence: true, length: { in: 1..20 }
  validates :email, presence: true, length: { in: 1..50 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  validates :password, length: { in: 6..20 }
  validates :role, presence: true, inclusion: { in: User.roles.keys }

  def admin_presence?
    raise if self.role == "role_common" && User.where(role: 'role_admin').count == 1
  end
end

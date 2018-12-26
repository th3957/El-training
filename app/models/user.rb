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
    if User.find_by(id: self.id).nil?
      true
    elsif self.role == "role_common" && User.find(self.id).role == "role_admin" && User.where(role: 'role_admin').count == 1
      raise
    end
  end
end

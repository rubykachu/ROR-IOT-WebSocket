class User < ApplicationRecord
  has_secure_password

  has_many :users_groups, dependent: :destroy
  has_many :groups, through: :users_groups

  scope :order_latest, -> { order(id: :desc) }

  def self.admin
    User.where(admin: true)
  end

  def self.find_by_username(username)
    find_by(username: username)
  end
end

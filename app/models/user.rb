class User < ApplicationRecord
  has_secure_password
  scope :order_latest, -> { order(id: :desc) }

  def self.admin
    User.where(admin: true)
  end

  def self.find_by_username(username)
    find_by(username: username)
  end
end

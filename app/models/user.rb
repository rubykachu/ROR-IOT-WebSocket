class User < ApplicationRecord
  has_secure_password

  has_many :users_devices, dependent: :destroy
  has_many :devices, through: :users_devices

  scope :order_latest, -> { order(id: :desc) }

  def self.admin
    User.where(admin: true)
  end

  def self.find_by_username(username)
    find_by(username: username)
  end

  def device?(name, code)
    if Device::CHARACTERS.exclude?(name) && Device::CHARACTERS.exclude?(code)
      devices.exists?(name: name, code: code)
    elsif Device::CHARACTERS.include?(name) && Device::CHARACTERS.exclude?(code)
      devices.exists?(code: code)
    elsif Device::CHARACTERS.include?(code) && Device::CHARACTERS.exclude?(name)
      devices.exists?(name: name)
    else
      devices.present?
    end
  end
end

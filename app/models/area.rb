class Area < ApplicationRecord
  has_many :devices
  has_many :devices_groups, through: :devices
  has_many :groups, through: :devices_groups
  has_many :users_groups, through: :groups, dependent: :destroy

  scope :common_order, -> { order(name: :asc) }
  scope :common_includes, -> { includes(devices: :area) }
end

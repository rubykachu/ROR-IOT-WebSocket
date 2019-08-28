class Group < ApplicationRecord
  has_many :devices_groups, dependent: :destroy
  has_many :devices, through: :devices_groups

  has_many :users_groups, dependent: :destroy
  has_many :users, through: :users_groups

  scope :order_alphabet, -> { order(name: :asc) }
  scope :common_includes, -> { includes(:users, :devices) }
end

class Group < ApplicationRecord
  has_many :devices_groups
  has_many :devices, through: :devices_groups

  scope :order_alphabet, -> { order(name: :asc) }
end

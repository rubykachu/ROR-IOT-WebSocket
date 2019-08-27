class Group < ApplicationRecord
  has_many :devices_groups, dependent: :destroy
  has_many :devices, through: :devices_groups

  scope :order_alphabet, -> { order(name: :asc) }
end

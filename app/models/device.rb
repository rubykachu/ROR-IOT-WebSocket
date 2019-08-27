class Device < ApplicationRecord
  belongs_to :area, optional: true
  has_many :devices_groups
  has_many :groups, through: :devices_groups, foreign_key: :group_id
  scope :order_alphabet, -> { order(name: :asc) }
end

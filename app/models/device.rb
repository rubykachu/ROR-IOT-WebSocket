class Device < ApplicationRecord
  belongs_to :area, optional: true
  has_many :devices_groups, dependent: :destroy
  has_many :groups, through: :devices_groups, foreign_key: :group_id

  has_many :users_groups, through: :groups
  has_many :users, through: :users_groups

  scope :common_order, -> { order(name: :asc) }
  scope :common_includes, -> { includes(:area, :users) }
end

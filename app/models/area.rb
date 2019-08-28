class Area < ApplicationRecord
  has_many :devices

  scope :common_order, -> { order(name: :asc) }
  scope :common_includes, -> { includes(:devices) }
end

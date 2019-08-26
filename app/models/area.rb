class Area < ApplicationRecord
  has_many :devices

  scope :order_alphabet, -> { order(name: :asc) }
end

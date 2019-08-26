class Area < ApplicationRecord
  scope :order_alphabet, -> { order(name: :asc) }
end

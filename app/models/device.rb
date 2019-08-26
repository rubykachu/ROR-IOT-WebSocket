class Device < ApplicationRecord
  scope :order_alphabet, -> { order(name: :asc) }
end

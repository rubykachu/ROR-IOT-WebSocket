class Group < ApplicationRecord
  scope :order_alphabet, -> { order(name: :asc) }
end

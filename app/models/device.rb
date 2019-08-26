class Device < ApplicationRecord
  belongs_to :area, optional: true

  scope :order_alphabet, -> { order(name: :asc) }
end

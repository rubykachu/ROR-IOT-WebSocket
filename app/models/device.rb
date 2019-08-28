class Device < ApplicationRecord
  CHARACTERS = %w[# +].freeze
  has_many :users_devices, dependent: :destroy
end

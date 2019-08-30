class Log < ApplicationRecord
  serialize :params, Hash

  scope :common_order, -> { order(created_at: :desc) }
end

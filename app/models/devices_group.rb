class DevicesGroup < ApplicationRecord
  belongs_to :device
  belongs_to :group
end

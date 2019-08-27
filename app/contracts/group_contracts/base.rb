class GroupContracts::Base < ApplicationContract
  attribute :record,     Group
  attribute :name,       String
  attribute :device_ids, Array[Integer]

  validates :name, :device_ids, presence: true
  validates :name, unique: true, length: { maximum: 50 }
  validates :device_ids, exists: {
                           model: Device.name,
                           in_array: true
                         }
end

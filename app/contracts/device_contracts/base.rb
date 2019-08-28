class DeviceContracts::Base < ApplicationContract
  attribute :record, Device
  attribute :name, String
  attribute :code, String

  validates :name, :code, presence: true
  validates :code, unique: true
end

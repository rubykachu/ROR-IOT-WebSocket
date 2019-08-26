class GroupContracts::Base < ApplicationContract
  attribute :record,    Group
  attribute :area_id,   Integer
  attribute :device_id, Integer

  validates :name, :area_id, :device_id, presence: true
  validates :name, length: { maximum: 50 }
end

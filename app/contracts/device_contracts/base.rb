class DeviceContracts::Base < ApplicationContract
  attribute :record,   Device
  attribute :name,     String
  attribute :position, Integer
  attribute :area_id,  Integer

  validates :name, presence: true, length: { maximum: 50 }
  validates :position, allow_blank: true, numericality: { only_integer: true }
  validates :area_id, exists: true, allow_blank: true
  validates :name, unique: {
                     case_sensitive: false,
                     message: I18n.t('errors.messages.already_exists_in_position'),
                     scope: [:name, :position]
                   },
                   if: Proc.new { |d| d.position.present? }
end

class DeviceContracts::Base < ApplicationContract
  attribute :record,   Device
  attribute :name,     String
  attribute :position, Integer
  attribute :area_id,  Integer

  validates :name, presence: true, length: { maximum: 50 }
  validates :position, presence: true, numericality: { only_integer: true }, if: Proc.new { |d| d.area_id.present? }
  validates :area_id, exists: true, presence: true, if: Proc.new { |d| d.position.present? }

  validates :name, unique: {
                     case_sensitive: false,
                     message: I18n.t('errors.messages.already_exists_in_position'),
                     scope: [:name, :position, :area_id]
                   },
                   if: Proc.new { |d| d.position.present? && d.area_id.present? }
end

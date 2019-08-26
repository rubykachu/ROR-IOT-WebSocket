class AreaContracts::Base < ApplicationContract
  attribute :record, User
  attribute :name, String
  attribute :slug, String

  validates :name, :slug, presence: true, length: { maximum: 50 }
  validates :name, unique: { case_sensitive: false }
end

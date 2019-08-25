class UserContracts::Base < ApplicationContract
  attribute :record, User
  attribute :username, String
  attribute :fullname, String
  attribute :password, String
  attribute :admin, Integer

  validates :username, :password, presence: true, length: { maximum: 20 }
  validates :admin, inclusion: { in: [0, 1] }, allow_blank: true
  validates :username, unique: true

  def after_valid
    record.password = password
  end
end

class AuthContracts::Base < ApplicationContract
  attribute :record,   User
  attribute :username, String
  attribute :password, String

  validate :authenticate!

  private

  def authenticate!
    user = User.find_by_username(username)
    return if user&.authenticate(password)
    errors.add(:unauthorized, :unauthorized)
  end
end

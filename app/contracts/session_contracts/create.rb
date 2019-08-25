class SessionContracts::Create < ApplicationContract
  attribute :record, User
  attribute :username, String
  attribute :password, String
  attribute :remember_me, String

  validates :remember_me, inclusion: { in: %w[true false] }, allow_blank: true
  validate :authenticate

  def authenticate
    user = User.find_by(username: username)
    return if user&.authenticate(password)
    errors.add(:invalid_authenticate, "Login failed")
  end
end

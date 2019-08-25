class User < ApplicationRecord
  has_secure_password

  def self.find_by_username(username)
    find_by(username: username)
  end
end

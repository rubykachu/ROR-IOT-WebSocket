class UserContracts::Create < UserContracts::Base
  validates :password, presence: true, length: { maximum: 20 }
end

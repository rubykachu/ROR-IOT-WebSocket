class UserContracts::Base < ApplicationContract
  attribute :record,    User
  attribute :username,  String
  attribute :fullname,  String
  attribute :password,  String
  attribute :admin,     Integer
  attribute :group_ids, Array[Integer]

  validates :username, presence: true, length: { maximum: 20 }
  validates :admin, inclusion: { in: [0, 1] }, allow_blank: true
  validates :username, unique: true
  validates :group_ids, exists: {
                           model: Group.name,
                           in_array: true
                         },
                         allow_blank: true

  def after_valid
    record.password = password if password.present?
  end
end

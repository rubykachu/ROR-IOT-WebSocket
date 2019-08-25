class UserContracts::Update < UserContracts::Base
  validates :password, allow_blank: true, length: { maximum: 20 }
  validate :must_have_least_1_admin

  private

  def must_have_least_1_admin
    return unless admin.zero?
    admin_ids = User.admin.ids
    return if admin_ids.size > 1
    return if admin_ids.exclude?(record.id)
    errors.add(:admin, I18n.t('user.update.at_least_1_admin'))
  end
end

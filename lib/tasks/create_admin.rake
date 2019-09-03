namespace :create do
  # Create admin
  # rails create:admin
  task admin: :environment do
    User.find_or_create_by username: 'admin' do |admin|
      admin.password = 'Abc123@@@'
      admin.admin = true
      admin.fullname = 'Administrator'
    end
  end
end

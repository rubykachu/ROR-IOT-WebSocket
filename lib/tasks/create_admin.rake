namespace :create do
  # Create admin
  # rails create:admin
  task admin: :environment do
    User.create! username: 'admin', password: 'Abc123@@@', admin: true, fullname: 'Mr. Minh'
  end
end

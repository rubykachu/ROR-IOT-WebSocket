class InitAdmin < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['create:admin'].invoke
  end

  def down
    User.find_by_username('admin')&.destroy
  end
end

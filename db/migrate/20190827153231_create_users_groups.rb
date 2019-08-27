class CreateUsersGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :users_groups do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.timestamps null: true
    end

    add_index :users_groups, [:user_id, :group_id], unique: true
  end
end

class CreateUsersDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :users_devices do |t|
      t.belongs_to :user
      t.belongs_to :device
      t.timestamps null: true
    end

    add_index :users_devices, [:user_id, :device_id], unique: true
  end
end

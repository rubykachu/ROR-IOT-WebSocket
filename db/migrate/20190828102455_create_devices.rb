class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :code, null: false
      t.timestamps null: true
    end

    add_index :devices, :code, unique: true
  end
end

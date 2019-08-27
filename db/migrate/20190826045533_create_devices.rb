class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.integer :position, null: true
      t.belongs_to :area, null: true, foreign_key: true
      t.timestamps null: true
    end

    add_index :devices, [:name, :position, :area_id], unique: true
  end
end

class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :ip_address
      t.string :params
      t.timestamps
    end
  end
end

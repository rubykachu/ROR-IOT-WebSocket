class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :fullname
      t.string :password_digest
      t.string :cookie_digest
      t.boolean :admin
      t.timestamps null: true
    end
    add_index :users, :username, unique: true
    add_index :users, :cookie_digest
  end
end

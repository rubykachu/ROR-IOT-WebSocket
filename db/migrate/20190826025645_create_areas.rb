class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps null: true
    end
  end
end

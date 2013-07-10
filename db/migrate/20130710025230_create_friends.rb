class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :uid
      t.string :name
      t.string :first_name
      t.string :last_name
      t.integer :location_id
      t.string :image_url

      t.timestamps
    end
    add_index :friends, [:uid]
    add_index :friends, [:name]
  end
end

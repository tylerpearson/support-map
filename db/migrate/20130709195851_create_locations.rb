class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :congressional_district
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

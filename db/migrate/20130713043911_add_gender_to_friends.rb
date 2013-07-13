class AddGenderToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :gender, :string
  end
end

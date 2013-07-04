class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :image_url, :string
    add_column :users, :location, :string
    add_column :users, :verified, :boolean
  end
end

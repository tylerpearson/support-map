class RemoveTimestampsFromFriendsUsers < ActiveRecord::Migration
  def change
    remove_column :friends_users, :created_at, :string
    remove_column :friends_users, :updated_at, :string
  end
end

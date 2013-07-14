class AddIndexToFriendsUsers < ActiveRecord::Migration
  def change
    add_index(:friends_users, [:friend_id, :user_id], :unique => true)
  end
end

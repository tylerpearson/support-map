class FriendsUsers < ActiveRecord::Migration
  def change
    create_table :friends_users, :id => false, :force => true do |t|
      t.integer :friend_id
      t.integer :user_id
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end
  end
end
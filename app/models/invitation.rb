class Invitation < ActiveRecord::Base

  validates :friend_id, :user_id, :presence => true

  belongs_to :user
  belongs_to :friend

end

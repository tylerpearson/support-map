class Friend < ActiveRecord::Base

  belongs_to :location
  has_many :invitations

  validates :first_name, :last_name, :name, :location_id, :username, :gender, :uid, :presence => true

end

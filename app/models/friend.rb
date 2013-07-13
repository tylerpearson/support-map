class Friend < ActiveRecord::Base

  belongs_to :location
  has_many :invitations

end

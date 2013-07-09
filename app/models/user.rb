class User < ActiveRecord::Base

  validates :provider, :first_name, :oauth_token, :name, :presence => true
  validates_uniqueness_of :uid

  geocoded_by :address
  after_validation :geocode

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.gender = auth.info.gender
      user.nickname = auth.info.nickname
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image_url = auth.info.image
      user.location = auth.info.location
      user.verified = auth.info.verified
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def address
    if zip_code
      "#{zip_code}"
    elsif !location.nil?
      "#{location}"
    end
  end

end

class Location < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true

  geocoded_by :name

  after_validation :add_city_and_state_info
  after_validation :geocode
  after_validation :add_congressional_district, :if => :is_a_congressional_race?

  def is_a_congressional_race?
    if ENV["CAMPAIGN_TYPE"].downcase == "congress"
      true
    else
      false
    end
  end



  private

    def add_city_and_state_info
      location = self.name
      self.state = location.rpartition(", ").last
      self.city = location.rpartition(", ").first
    end

    def add_congressional_district
      response = HTTParty.get("http://congress.mcommons.com/districts/lookup.json?lat=#{self.latitude}&lng=#{self.longitude}")
      if response['error'].nil?
        self.congressional_district = response['federal']['district']
      end
    end

end

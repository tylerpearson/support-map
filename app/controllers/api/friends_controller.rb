class Api::FriendsController < ApplicationController

  before_filter :fetch_user

  def fetch_user
    @user = current_user
    @graph = Koala::Facebook::API.new(@user.oauth_token)
  end

  def index
    @friends = @graph.get_connections("me", "friends", "fields"=>"id,name,location,first_name,last_name,picture")

    if ENV["CAMPAIGN_TYPE"].downcase == "state" || ENV["CAMPAIGN_TYPE"].downcase == "senate"
      @friends = @friends.find_all{|friend| !friend['location'].nil? && states_match?(friend['location']['name']) }
    elsif ENV["CAMPAIGN_TYPE"].downcase == "congress"
      @friends = @friends.find_all{|friend| !friend['location'].nil? && districts_match?(friend['location']['name']) }
    end

    respond_to do |format|
      format.json { render json: @friends }
    end
  end

  protected

    def states_match?(fb_location)
      state = state_from_facebook_location(fb_location)
      state.strip!

      if state.downcase == ENV["CAMPAIGN_STATE_FULL"].downcase
        true
      else
        false
      end
    end

    def districts_match?(fb_location)

      if state_from_facebook_location(fb_location) == ENV["CAMPAIGN_STATE_FULL"].downcase
        location = Location.find_or_create_by(name: fb_location)
      else
        return false
      end

      if location.congressional_district == ENV["CAMPAIGN_CONGRESSIONAL_DISTRICT"] && location.state.downcase == ENV["CAMPAIGN_STATE_FULL"].downcase
        true
      else
        false
      end
    end

    def state_from_facebook_location(fb_location)
      fb_location.rpartition(", ").last.downcase
    end

end
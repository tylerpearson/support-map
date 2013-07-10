class Api::FriendsController < ApplicationController

  before_filter :fetch_user

  def fetch_user
    @user = current_user
    @graph = Koala::Facebook::API.new(@user.oauth_token)
  end

  def index
    @friends = @graph.get_connections("me", "friends", "fields"=>"id,name,location,first_name,last_name,picture")

    if ENV["CAMPAIGN_TYPE"].downcase == "state" || ENV["CAMPAIGN_TYPE"].downcase == "senate"
      @friends.map! do |friend|
        if friend['location'].nil?
          next
        else
          states_match?(friend)
        end
      end.compact!
    elsif ENV["CAMPAIGN_TYPE"].downcase == "congress"
      @friends.map! do |friend|
        if friend['location'].nil?
          next
        else
          districts_match?(friend)
        end
      end.compact!
    end

    respond_to do |format|
      format.json { render json: @friends }
    end
  end

  protected

    def states_match?(friend)
      fb_location = friend['location']['name']

      state = state_from_facebook_location(fb_location).strip

      if state.downcase == ENV["CAMPAIGN_STATE_FULL"].downcase
        location = Location.find_or_create_by(name: fb_location)
        current_friend = Friend.find_or_create_by(
          uid: friend["id"],
          name: friend["name"],
          first_name: friend["first_name"],
          last_name: friend["last_name"],
          location_id: location.id,
          image_url: friend["picture"]["data"]["url"]
        )
      else
        return
      end
      current_friend
    end

    def districts_match?(friend)
      fb_location = friend['location']['name']

      if state_from_facebook_location(fb_location) == ENV["CAMPAIGN_STATE_FULL"].downcase
        location = Location.find_or_create_by(name: fb_location)
      else
        return
      end

      if location.congressional_district == ENV["CAMPAIGN_CONGRESSIONAL_DISTRICT"] && location.state.downcase == ENV["CAMPAIGN_STATE_FULL"].downcase
        current_friend = Friend.find_or_create_by(
          uid: friend["id"],
          name: friend["name"],
          first_name: friend["first_name"],
          last_name: friend["last_name"],
          location_id: location.id,
          image_url: friend["picture"]["data"]["url"]
        )
      end
      current_friend
    end

    def state_from_facebook_location(fb_location)
      fb_location.rpartition(", ").last.downcase
    end

end
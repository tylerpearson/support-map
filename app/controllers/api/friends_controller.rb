class Api::FriendsController < ApplicationController

  before_filter :fetch_user

  def fetch_user
    @user = current_user
    @graph = Koala::Facebook::API.new(@user.oauth_token)
  end

  def index
    @friends = @graph.get_connections("me", "friends", "fields"=>"id,name,location,first_name,last_name")

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
      state = fb_location.rpartition(", ").last
      state.strip!

      if state.downcase == ENV["CAMPAIGN_STATE_FULL"].downcase
        true
      else
        false
      end
    end

    def districts_match(fb_location)
      true
    end

end
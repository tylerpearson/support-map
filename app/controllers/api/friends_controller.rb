class Api::FriendsController < ApplicationController

  before_filter :fetch_user

  def fetch_user
    @user = current_user
    @graph = Koala::Facebook::API.new(@user.oauth_token)
  end

  def index
    @friends = @graph.get_connections("me", "friends", "fields"=>"id,name,location,first_name,last_name")

    @friends = @friends.find_all{|friend| !friend['location'].nil? }
    respond_to do |format|
      format.json { render json: @friends }
    end
  end


end
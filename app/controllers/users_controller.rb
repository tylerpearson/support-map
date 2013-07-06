class UsersController < ApplicationController
  def index
    @users = User.all

    gon.jbuilder "app/views/users/index.json.jbuilder", as: "endorsements"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.to_json }
    end
  end
end

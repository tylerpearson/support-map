class HomeController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    gon.jbuilder "app/views/users/index.json.jbuilder", as: "endorsements"
  end
end

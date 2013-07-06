class HomeController < ApplicationController
  def index
    @users = User.all
    gon.jbuilder "app/views/users/index.json.jbuilder", as: "endorsements"
  end
end

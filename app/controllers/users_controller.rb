class UsersController < ApplicationController
  def index
    @users = User.all

    gon.jbuilder "app/views/users/index.json.jbuilder", as: "endorsements"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def update
    @user = User.find(current_user.id)
    @graph = Koala::Facebook::API.new(@user.oauth_token)

    comment = params[:user][:comment]

    if params[:share] == "yes"
      permissions = @graph.get_connections('me','permissions')
      if permissions[0]['publish_actions'].to_i == 1
        if Rails.env.production?
          @graph.put_wall_post(comment, {
            "name" => ENV["FB_LINK_NAME"],
            "link" => ENV["FB_LINK_URL"],
            "caption" => ENV["FB_LINK_CAPTION"],
            "description" => ENV["FB_LINK_DESCRIPTION"],
            "picture" => ENV["FB_LINK_PICTURE_URL"]
          })
        else
          logger.info "LOGGED"
        end
      end
    end

    respond_to do |format|
      if @user.update_columns(params[:user])
        UserMailer.admin_notification_email(@user).deliver
        cookies[:added_name] = { :value => true, :expires => 1.month.from_now }

        format.json { render json: @user, :only => [:uid, :name, :location, :comment, :latitude, :longitude] }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

    def user_params
      params.require(:zip_code, :comment)
    end

end

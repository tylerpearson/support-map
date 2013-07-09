class UsersController < ApplicationController
  def index
    @users = User.all

    gon.jbuilder "app/views/users/index.json.jbuilder", as: "endorsements"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.to_json }
    end
  end

  def update
    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update_columns(params[:user])
        UserMailer.admin_notification_email(@user).deliver
        cookies[:added_name] = { :value => true, :expires => 1.month.from_now }

        format.json { render json: @user, :only => [:id, :name, :location, :comment, :latitude, :longitude] }
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

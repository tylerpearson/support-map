class Api::InvitationsController < ApplicationController

  def create
    @friend = Friend.find_by_uid(params[:friend_uid])
    @invitation = Invitation.new(friend_id: @friend.id, user_id: current_user.id)

    respond_to do |format|
      if @invitation.save
        format.json { render json: "success", :status => :ok }
      else
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
        params.require(:friend_uid)
    end

end
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @relationship = @user.followers.find_by(follower: current_user)
  end
end

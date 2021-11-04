class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @relationship = @user.followers.find_by(follower: current_user)
  end
  
end

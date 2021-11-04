class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    other_user = User.find(params[:user_id])
    @relationship = Relationship.new(
      follower_id: current_user.id,
      followed_id: other_user.id)
    @relationship.save
    redirect_to users_path
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    if @relationship.destroy
      redirect_to users_path
    else
      render :root_path
    end
  end
  
end
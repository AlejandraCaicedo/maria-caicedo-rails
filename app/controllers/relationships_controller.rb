class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    followed = User.find(params[:user_id])
    @relationship = Relationship.new(
      follower_id: current_user.id,
      followed_id: followed.id
    )

    if @relationship.save
      redirect_to users_path
    else
      render :root_path
    end
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

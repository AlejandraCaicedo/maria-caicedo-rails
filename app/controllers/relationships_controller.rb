class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @relationship = Relationship.where(follower: current_user.id)
  end

  def show
    @relationship = Relationship.find(params[:id])
  end

  def new
    @relationship = Relationship.new
  end

  def create
    other_user = User.find(params[:user_id])
    @relationship = Relationship.new(
      follower_id: current_user.id,
      followed_id: other_user.id
    )

    if @relationship.save
      redirect_to @relationship
    else
      render :root_path
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    redirect_to root_path
  end

end

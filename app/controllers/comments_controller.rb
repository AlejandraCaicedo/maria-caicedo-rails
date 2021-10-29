class CommentsController < ApplicationController

# http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.commenter = current_user.username
    if @comment.save
      redirect_to article_path(@article)
    else
      render :new
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end

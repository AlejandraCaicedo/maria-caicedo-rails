class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.commenter = current_user.username
    if @comment.save
      redirect_to article_path(@article)
    else
      render :root_path
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    current_user.comments << @comment
    redirect_to article_path(@article)
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

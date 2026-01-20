class CommentsController < ApplicationController
  before_action :set_blog

  def create
    @comment = @blog.comments.new(comment_params)

    if @comment.save
      redirect_to @blog, notice:  "Comment was successfully created."
    else
      redirect_to @blog, alert: @comment.errors.full_messages.join(", ")
    end
  end

  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to @blog, notice: "Comment was successfully deleted."
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

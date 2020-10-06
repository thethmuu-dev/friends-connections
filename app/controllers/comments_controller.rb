class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)

    respond_to do |f|
      if @comment.save
        f.html { redirect_to blog_path(@blog) }
      else
        f.html { redirect_to blog_path(@blog), notice: "Couldn't Post..." }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:blog_id, :content)
  end
end

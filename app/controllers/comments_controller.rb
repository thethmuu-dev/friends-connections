class CommentsController < ApplicationController
  before_action :set_blog, only: [:create, :edit, :update]

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)

    respond_to do |f|
      if @comment.save
        f.js { render :index }
      else
        f.html { redirect_to blog_path(@blog), notice: "Couldn't Post..." }
      end
    end
  end

  def edit
    @comment = @blog.comments.find(params[:id])
    respond_to do |f|
      flash.now[:notice] = 'Comment Edit'
      f.js {render :edit}
    end
  end

  def update
    @comment = @blog.comments.find(params[:id])
    respond_to do |f|
      if @comment.update(comment_params)
        flash.now[:notice] = 'Comment Edited'
        f.js { render :index }
      else
        flash.now[:notice] = 'Comment Cannot be Edited'
        f.js { render :edit_error }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'Comment deleted'
      format.js { render :index }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:blog_id, :content)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end

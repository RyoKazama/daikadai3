class CommentsController < ApplicationController

  before_action :set_comment, only:[:edit,:update,:destroy,:show]


  def create
      @comment = current_user.comments.build(comments_params)
      @topic = @comment.topic

      respond_to do |format|
        if @comment.save
          format.html {redirect_to topic_path(@topic),notice: 'コメントを投稿しました！'}
          format.js {render :index}
        else
          format.html {render :new}
        end
      end
  end

  def edit
  end

  def update
      @comment = Comment.find(params[:id])
      if @comment.update(comments_params)
        redirect_to topic_path(@comment.topic), notice:"コメントが編集されました!"
      else
        redirect_to edit_topic_comment_path, notice:"コメントを編集してください!"
      end
  end


  def destroy
    @comment=Comment.find(params[:id])
    flash[:notice] = 'コメントを削除しました。'
    respond_to do |format|
          @comment.destroy
           format.js { render :index }
    end
  end

  private

    def comments_params
      params.require(:comment).permit(:topic_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end


end

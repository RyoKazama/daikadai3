class CommentsController < ApplicationController

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

end

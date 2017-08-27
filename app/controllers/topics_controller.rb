class TopicsController < ApplicationController

before_action :authenticate_user!
before_action :set_topic, only:[:edit,:update,:destroy,:show]

  def index
    @topics = Topic.all
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.create(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice:"投稿しました！"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render 'new', notice:"投稿内容がありません。"
    end
  end

  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end

  def edit
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def update
    @topic.update(topics_params)
    if @topic.save
      redirect_to topics_path,notice:"投稿を更新しました！"
    else
      render 'edit',notice:"投稿内容がありません。"
    end

  end

  def destroy
    @topic.destroy
    redirect_to topics_path,notice:"ブログを削除しました！"
  end

private
  def topics_params
    params.require(:topic).permit(:content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end

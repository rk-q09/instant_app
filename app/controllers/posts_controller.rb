class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @q = Post.ransack(params[:q])
    @search_results = @q.result(distinct: true)
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました。"
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿が削除されました。"
    redirect_to current_user
  end

  private

   def post_params
     params.require(:post).permit(:caption, :picture)
   end

   def correct_user
     @post = current_user.posts.find_by(id: params[:id])
     redirect_to root_url if @post.nil?
   end
end

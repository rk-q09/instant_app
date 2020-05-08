class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.iine(current_user)
    redirect_to @post
  end

  def destroy
    @post = Like.find(params[:id]).post
    @post.not_iine(current_user)
    redirect_to @post
  end
end

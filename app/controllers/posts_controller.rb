class PostsController < ApplicationController
  def index
    @posts = Post.includes(:category).all
  end
end

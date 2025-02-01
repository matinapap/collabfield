class PostsController < ApplicationController
  def index
    @posts = Post.includes(:category).all
  end

  def show
    @post = Post.find_by(id: params[:id])
    
    unless @post
      redirect_to posts_path, alert: "Το post δεν βρέθηκε."
    end
  end
end

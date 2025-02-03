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

  def hobby
    @posts = Post.where(category: 'hobby').paginate(page: params[:page], per_page: 10)
    @categories = Category.all
  end

  def study
    @posts = Post.where(category: 'study').paginate(page: params[:page], per_page: 10)
    @categories = Category.all
  end

  def team
    @posts = Post.where(category: 'team').paginate(page: params[:page], per_page: 10)
    @categories = Category.all
  end

  private

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = Post.where(category: params[:category]).paginate(page: params[:page], per_page: 10)
  end

  def no_posts_partial_path
    @posts.empty? ? 'posts/branch/no_posts' : 'shared/empty_partial'
  end
end

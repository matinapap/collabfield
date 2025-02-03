class PostsController < ApplicationController
  def index
    @categories = Category.all
    @posts = Post.includes(:category).all
  end

  def show
    @post = Post.find_by(id: params[:id])
    
    unless @post
      redirect_to posts_path, alert: "Το post δεν βρέθηκε."
    end
  end

  def hobby
    @categories = Category.where(branch: 'hobby')  # Φορτώνουμε τις κατηγορίες που ανήκουν στο 'hobby'
    @posts = Post.where(category_id: @categories.pluck(:id))
    posts_for_branch(params[:action])
  end

  def study
    @categories = Category.where(branch: 'study')  # Φορτώνουμε τις κατηγορίες που ανήκουν στο 'hobby'
    @posts = Post.where(category_id: @categories.pluck(:id))
    posts_for_branch(params[:action])
  end

  def team
    @categories = Category.where(branch: 'team')  # Φορτώνουμε τις κατηγορίες που ανήκουν στο 'hobby'
    @posts = Post.where(category_id: @categories.pluck(:id))
    posts_for_branch(params[:action])
  end

  private

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = Post.where(category_id: @categories.pluck(:id))
  end  

  def no_posts_partial_path
    @posts.empty? ? 'posts/branch/no_posts' : 'shared/empty_partial'
  end
end

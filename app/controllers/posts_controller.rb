class PostsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: [:new]

  def index
    @categories = Category.all
    @posts = Post.includes(:category).all

     # Φιλτράρισμα με βάση το branch και την κατηγορία
     if params[:branch].present? && params[:category].present?
      @posts = @posts.by_category(params[:branch], params[:category])
    # Φιλτράρισμα μόνο με βάση το branch
    elsif params[:branch].present?
      @posts = @posts.by_branch(params[:branch])
    # Αναζήτηση
    elsif params[:search].present?
      @posts = @posts.search(params[:search])
    end
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

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save 
      redirect_to post_path(@post) 
    else
      redirect_to root_path
    end
  end

  # def post_params
  #   params.require(:post).permit(:content, :title, :category_id)
  #                        .merge(user_id: current_user.id)
  # end

  private

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = Post.where(category_id: @categories.pluck(:id))
  end  

  def no_posts_partial_path
    @posts.empty? ? 'posts/shared/_no_posts.html.erb' : 'shared/empty_partial'
  end

  def set_categories
    @categories = Category.all
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id).merge(user_id: current_user.id)
  end

  def get_posts
    branch = params[:action]
    search = params[:search]
    category = params[:category]
  
    if category.blank? && search.blank?
      posts = Post.by_branch(branch).all
    elsif category.blank? && search.present?
      posts = Post.by_branch(branch).search(search)
    elsif category.present? && search.blank?
      posts = Post.by_category(branch, category)
    elsif category.present? && search.present?
      posts = Post.by_category(branch, category).search(search)
    else
    end
     @posts = posts
  end
end

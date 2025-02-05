class PostsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: [:new]

  def index
    @categories = Category.all
    @posts = Post.includes(:category).all

    if params[:branch].present? && params[:category].present?
      @posts = @posts.by_category(params[:branch], params[:category])
    elsif params[:branch].present?
      @posts = @posts.by_branch(params[:branch])
    elsif params[:search].present?
      @posts = @posts.search(params[:search])
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    
    unless @post
      redirect_to posts_path, alert: "Το post δεν βρέθηκε." and return
    end

    @message_has_been_sent = conversation_exist? if user_signed_in?
  end

  def new
    @categories = Category.where(branch: params[:branch])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def hobby
    posts_for_branch('hobby')
  end

  def study
    posts_for_branch('study')
  end

  def team
    posts_for_branch('team')
  end

  private

  def conversation_exist?
    Private::Conversation.between_users(current_user.id, @post.user.id).present?
  end

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = Post.where(category_id: @categories.pluck(:id))
  end  

  def post_params
    params.require(:post).permit(:title, :content, :category_id).merge(user_id: current_user.id)
  end

  def get_posts
    @posts = Post.by_branch(params[:action])
    @posts = @posts.search(params[:search]) if params[:search].present?
    @posts = @posts.by_category(params[:action], params[:category]) if params[:category].present?
  end
end

class PostsController < ApplicationController

  before_action :authenticate_user!,
                except: [:index]

                # authenticate_user for new & edit only

  def index
    news_url = 'https://newsapi.org/v1/articles?source=bloomberg&sortBy=top&apiKey=632f013c674c447090449ec693e2eb98'

    response = HTTParty.get(news_url)
    @news_data = response
    #render json: response
    @all_posts = current_user.posts
    @new_post = current_user.posts.new #tag new post to current user, create a spare new in case user creates a new post
  end

  def show
    @post = Post.find(params[:id])
    #render html: 'show one post'
  end

  def new
    render html: 'show form to create new post'
  end

  def edit # to render individual post in a form (see edit.html)
    @editing_post = Post.find(params[:id])
    # redirect_to edit_post_path
    #render json: @editing_post
  end

  def create
    #creating_post = params.require(:post).permit(:title, :content, :user_id)  # see documentation for reason. else get attribute error from mass assignment issue

    # alternatively:
    # creating_post = current_user.post.Build
    # creating_post.title = params[:post][:title]

    # render json: creating_post

    Post.create(post_params)
    redirect_to posts_path
  end

  def update
    # render json: post_update_params
    updated_post = Post.find(params[:id]) # need to specify id of post else entire Post db is updated i.e. "mass assignment" (don't confuse with user id)
    updated_post.update(params[:post])
    redirect_to posts_path
  end

  def destroy
    deleted_post = Post.destroy(params[:id])
    deleted_post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def post_update_params
    params.require(:post).permit(:title, :content)
  end


end

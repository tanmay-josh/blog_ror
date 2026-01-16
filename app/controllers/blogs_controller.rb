class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @blogs = Blog.published.order(created_at: :desc)
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog, notice:  "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice:  "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: "Blog was successfully destroyed."
  end

  def publish
    service = PublishBlogService.new(@blog)
    
    if service.call
      redirect_to @blog, notice: "Blog was successfully published."
    else
      redirect_to @blog, alert:  "Failed to publish blog."
    end
  end

  def published
    @blogs = Blog.published.order(created_at: :desc)
    render :index
  end

  def unpublished
    @blogs = Blog.unpublished.order(created_at: :desc)
    render :index
  end


  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :published)
  end
end
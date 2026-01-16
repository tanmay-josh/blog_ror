class PublishBlogService
  def initialize(blog)
    @blog = blog
  end

  def call
    return false if @blog.published?

    if @blog.update(published: true)
      log_publication
      true
    else
      false
    end
  end

  private

  def log_publication
    Rails.logger.info "Blog ##{@blog.id} '#{@blog.title}' was published at #{Time.current}"
  end
end
class PublishBlogJob < ApplicationJob
  queue_as :default

  def perform(blog_id)
    blog = Blog.find_by(id: blog_id)
    return unless blog

    service = PublishBlogService.new(blog)
    service.call
  end
end

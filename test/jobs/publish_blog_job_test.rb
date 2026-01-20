# app/jobs/publish_blog_job.rb
class PublishBlogJob < ApplicationJob
  queue_as :default

  def perform(blog_id)
    blog = Blog.find(blog_id)
    blog.update!(published: true)
  end
end
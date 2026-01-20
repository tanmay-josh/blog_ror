# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Comment.destroy_all
Blog.destroy_all

# Create 20 blogs
20.times do |i|
  blog = Blog.create(
    title: "Blog Post #{i + 1}",
    body:  "This is the content for blog post number #{i + 1}.  It contains some interesting information.",
    published: i < 10  # First 10 are published
  )
  if blog.published?
    rand(1..5).times do
      blog.comments.create(body: "This is a comment on blog #{i + 1}")
    end
  end
end

puts "Created #{Blog.count} blogs"
puts "#{Blog.published.count} published"
puts "#{Blog.unpublished.count} unpublished"
puts "Created #{Comment.count} comments"

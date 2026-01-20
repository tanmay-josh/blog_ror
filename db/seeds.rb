# Clear existing data
Comment.destroy_all
Blog.destroy_all

# Create 20 blogs using Faker
20.times do |i|
  blog = Blog. create(
    title: Faker::Book. title,
    body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    published: i < 10
  )

  if blog. published?
    rand(1..5).times do
      blog.comments.create(
        body: Faker::Lorem.paragraph(sentence_count: 2)
      )
    end
  end
end

puts "Created #{Blog.count} blogs"
puts "#{Blog.published.count} published"
puts "#{Blog.unpublished. count} unpublished"
puts "Created #{Comment.count} comments"

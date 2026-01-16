namespace :blog do
  desc "Print published and unpublished blog counts"
  task stats: :environment do
    published_count = Blog.published.count
    unpublished_count = Blog.unpublished.count
    total_count = Blog.count

    puts "=" * 40
    puts "Blog Statistics"
    puts "=" * 40
    puts "Total blogs: #{total_count}"
    puts "Published: #{published_count}"
    puts "Unpublished: #{unpublished_count}"
    puts "=" * 40
  end
end
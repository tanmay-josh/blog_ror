namespace :benchmark do
  desc "Benchmark blog index query"
  task blog_index: :environment do
    require "benchmark"

    puts "Benchmarking Blog. all without includes:"
    time1 = Benchmark.measure do
      blogs = Blog.all
      blogs.each do |blog|
        blog.comments. count
      end
    end
    puts "Time: #{time1.real} seconds"

    puts "\nBenchmarking Blog.all with includes:"
    time2 = Benchmark.measure do
      blogs = Blog.includes(:comments)
      blogs.each do |blog|
        blog.comments.count
      end
    end
    puts "Time: #{time2.real} seconds"

    improvement = ((time1.real - time2.real) / time1.real * 100).round(2)
    puts "\nPerformance improvement: #{improvement}%"
  end
end

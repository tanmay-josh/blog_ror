require "benchmark"

module Api
  module V1
    class BlogsController < ApplicationController
      def index
        result = Benchmark.measure do
          @blogs = Blog.published.includes(:comments).order(created_at: :desc)
        end

        Rails.logger.info "Query execution time: #{result.real} seconds"

        render json: @blogs
      end

      def show
        @blog = Blog.find(params[:id])
        render json: @blog
      end
    end
  end
end

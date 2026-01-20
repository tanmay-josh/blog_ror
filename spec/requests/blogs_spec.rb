require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /blogs" do
    let!(:published_blogs) { create_list(:blog, 3, :published) }
    let!(:unpublished_blogs) { create_list(:blog, 2) }

    it 'returns http success' do
      get blogs_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all blogs' do
      get blogs_path
      expect(response. body).to include(published_blogs.first.title)
      expect(response.body).to include(unpublished_blogs.first.title)
    end
  end

  describe "GET /blogs/published" do
    let!(:published_blogs) { create_list(:blog, 3, :published) }
    let!(:unpublished_blogs) { create_list(:blog, 2) }

    it 'returns http success' do
      get published_blogs_path
      expect(response).to have_http_status(:success)
    end

    it 'displays only published blogs' do
      get published_blogs_path
      expect(response.body).to include(published_blogs. first.title)
      expect(response.body).not_to include(unpublished_blogs.first.title)
    end
  end

  describe "GET /blogs/: id" do
    let(:blog) { create(:blog, :published, :with_comments) }

    it 'returns http success' do
      get blog_path(blog)
      expect(response).to have_http_status(:success)
    end

    it 'displays blog details' do
      get blog_path(blog)
      expect(response.body).to include(blog.title)
      expect(response.body).to include(blog.body)
    end

    it 'displays comments' do
      get blog_path(blog)
      blog.comments.each do |comment|
        expect(response.body).to include(comment.body)
      end
    end
  end

  describe "POST /blogs" do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          blog: {
            title: 'Test Blog',
            body: 'This is a test blog post with enough content'
          }
        }
      end

      it 'creates a new blog' do
        expect {
          post blogs_path, params: valid_attributes
        }.to change(Blog, :count).by(1)
      end

      it 'redirects to the created blog' do
        post blogs_path, params: valid_attributes
        expect(response).to redirect_to(blog_path(Blog. last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          blog: {
            title: '',
            body: 'Short'
          }
        }
      end

      it 'does not create a new blog' do
        expect {
          post blogs_path, params:  invalid_attributes
        }.not_to change(Blog, :count)
      end

      it 'renders the new template with unprocessable entity status' do
        post blogs_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /blogs/:id/publish" do
    let(:blog) { create(:blog) }

    it 'publishes the blog' do
      patch publish_blog_path(blog)
      expect(blog.reload.published?).to be true
    end

    it 'redirects to the blog' do
      patch publish_blog_path(blog)
      expect(response).to redirect_to(blog_path(blog))
    end
  end

  describe "DELETE /blogs/: id" do
    let! (:blog) { create(:blog) }

    it 'destroys the blog' do
      expect {
        delete blog_path(blog)
      }.to change(Blog, :count).by(-1)
    end

    it 'redirects to blogs list' do
      delete blog_path(blog)
      expect(response).to redirect_to(blogs_path)
    end
  end
end

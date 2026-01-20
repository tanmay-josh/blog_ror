require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'associations' do
    it { should have_many(:comments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  describe 'scopes' do
    let!(:published_blog) { create(:blog, :published) }
    let!(:unpublished_blog) { create(:blog) }

    describe '. published' do
      it 'returns only published blogs' do
        expect(Blog.published).to include(published_blog)
        expect(Blog.published).not_to include(unpublished_blog)
      end
    end

    describe '.unpublished' do
      it 'returns only unpublished blogs' do
        expect(Blog.unpublished).to include(unpublished_blog)
        expect(Blog.unpublished).not_to include(published_blog)
      end
    end
  end

  describe 'callbacks' do
    describe 'titleize_title' do
      it 'titleizes the title before save' do
        blog = create(:blog, title: 'my first blog post')
        expect(blog.title).to eq('My First Blog Post')
      end
    end

    describe 'schedule_publication' do
      it 'schedules a publish job after creation' do
        expect {
          create(:blog)
        }.to have_enqueued_job(PublishBlogJob)
      end
    end
  end

  describe '#published?' do
    it 'returns true when blog is published' do
      blog = create(:blog, :published)
      expect(blog.published?).to be true
    end

    it 'returns false when blog is not published' do
      blog = create(:blog)
      expect(blog.published?).to be false
    end
  end
end

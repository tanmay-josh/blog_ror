require 'rails_helper'

RSpec. describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:blog) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }

    describe 'blog_must_be_published' do
      let(:published_blog) { create(:blog, :published) }
      let(:unpublished_blog) { create(:blog) }

      it 'is valid when blog is published' do
        comment = build(:comment, blog: published_blog)
        expect(comment).to be_valid
      end

      it 'is invalid when blog is not published' do
        comment = build(:comment, blog: unpublished_blog)
        expect(comment).not_to be_valid
        expect(comment.errors[:blog]).to include('must be published to add comments')
      end
    end
  end
end

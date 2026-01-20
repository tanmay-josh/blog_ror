require 'swagger_helper'

RSpec.describe 'api/v1/blogs', type:  :request do
  path '/api/v1/blogs' do
    get 'Retrieves all published blogs' do
      tags 'Blogs'
      produces 'application/json'

      response '200', 'blogs found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type:  :string },
              body: { type: :string },
              published: { type: :boolean },
              created_at: { type: :string },
              updated_at: { type: :string },
              comments_count: { type: :integer },
              comments: {
                type: :array,
                items:  {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    body: { type: :string },
                    created_at: { type: :string }
                  }
                }
              }
            },
            required: [ 'id', 'title', 'body', 'published' ]
          }

        let!(:blogs) { create_list(:blog, 5, :published) }

        run_test!  do |response|
          data = JSON.parse(response.body)
          expect(data. length).to eq(5)
        end
      end
    end
  end

  path '/api/v1/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'blog found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            body: { type:  :string },
            published: { type: :boolean },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: [ 'id', 'title', 'body' ]

        let(:id) { create(:blog, :published).id }

        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end

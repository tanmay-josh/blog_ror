class BlogSerializer < ActiveModel:: Serializer
  attributes :id, :title, :body, :published, :created_at, :updated_at, :comments_count
  
  has_many :comments

  def comments_count
    object.comments.count
  end
end
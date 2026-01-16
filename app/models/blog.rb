class Blog < ApplicationRecord
    has_many :comments

    validates :title, presence: true
    validates :body, presence:  true, length: { minimum: 10 }

    before_save :titleize_title
    after_create :log_creation

    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }

    private

    def titleize_title
    self.title = title.titleize if title. present?
    end

    def log_creation
    Rails.logger.info "New blog created: #{title}"
    end
end

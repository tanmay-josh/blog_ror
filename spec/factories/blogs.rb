FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph(sentence_count: 5) }
    published { false }

    trait :published do
      published { true }
    end

    trait :with_comments do
      after(:create) do |blog|
        create_list(:comment, 3, blog: blog)
      end
    end
  end
end

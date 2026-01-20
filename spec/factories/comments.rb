FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 2) }
    association :blog, factory: [ :blog, :published ]
  end
end

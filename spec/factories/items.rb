FactoryBot.define do
  factory :item do
    name { "商品名" }
    description { "商品説明" }
    price_excluding_tax { 100 }
    published { false }
    position { 1 }
    image { Rails.root.join('spec/fixtures/files/images/test.jpeg') }

    trait :published do
      published { true }
    end

    trait :not_published do
      published { false }
    end
  end
end

FactoryBot.define do
  factory :cart do
    trait :with_user do
      user
    end
  end
end

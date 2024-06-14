FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |index| "administration-#{index}@example.com" }
    password { 'password' }
  end

  trait :with_cart do
    transient do
      cart
    end
  end
end

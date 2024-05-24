FactoryBot.define do
  factory :administrator do
    sequence(:email) { |index| "administration-#{index}@example.com" }
    password { 'password' }
  end
end

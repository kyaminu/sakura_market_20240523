FactoryBot.define do
  factory :administration do
    sequence(:email) { |index| "administration-#{index}@example.com" }
    password { 'password' }
  end
end

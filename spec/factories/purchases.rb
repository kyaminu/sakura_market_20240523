FactoryBot.define do
  factory :purchase do
    delivery_fee { 600 }
    handling_fee { 300 }
    name { 'お届け先さん' }
    phone_number { '09012345678' }
    postal_code { '1234567' }
    address { '住所' }

    trait :with_user do
      transient do
        user
      end
    end

    trait :with_address do
      after(:build) do |purchase, evaluator|
        address = evaluator.address || create(:address, user: purchase.user)
        purchase.address_id = address.id
        purchase.address = address.full_address
      end
    end
  end
end

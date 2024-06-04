FactoryBot.define do
  factory :purchase_item do
    quantity { 1 }

    trait :with_purchase do
      transient do
        purchase
      end
    end
  end
end

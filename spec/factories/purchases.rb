FactoryBot.define do
  factory :purchase do
    delivery_fee { 600 }
    handling_fee { 300 }
    name { 'お届け先さん' }
    phone_number { '09012345678' }
    postal_code { '1234567' }
    prefecture { '兵庫県' }
    city { '神戸市' }
    street { '三宮' }

    trait :with_user do
      transient do
        user
      end
    end

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end

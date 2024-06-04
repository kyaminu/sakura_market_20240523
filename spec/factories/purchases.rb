FactoryBot.define do
  factory :purchase do
    user
    delivery_fee { 600 }
    handling_fee { 300 }
    name { 'お届け先さん' }
    phone_number { '09012345678' }
    postal_code { '1234567' }
    address { '住所' }
  end
end

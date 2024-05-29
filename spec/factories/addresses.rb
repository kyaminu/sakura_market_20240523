FactoryBot.define do
  factory :address do
    user
    name { "送付先名前" }
    phone_number { "09000000000" }
    postal_code { "1234567" }
    prefecture { 1 }
    city { "神戸市中央区" }
    street { "三ノ宮" }
  end
end

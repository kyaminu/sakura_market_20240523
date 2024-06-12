FactoryBot.define do
  factory :address do
    name_kanji { "名前" }
    name_kana { "なまえ" }
    phone_number { "09000000000" }
    postal_code { "1234567" }
    prefecture_code { 1 }
    city { "神戸市中央区" }
    street { "三ノ宮" }

    trait :with_user do
      user
    end
  end
end

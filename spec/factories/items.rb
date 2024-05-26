FactoryBot.define do
  factory :item do
    name { "商品名" }
    description { "商品説明" }
    price_excluding_tax { 100 }
    published { false }
    position { 1 }
    tax_rate { "0.08" }
    images { Rails.root.join('spec/fixtures/files/images/test.jpeg') }
  end
end

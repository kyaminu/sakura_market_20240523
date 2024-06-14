describe '購入ページ', type: :system do
  let(:user) { create(:user, :with_cart) }

  before do
    sign_in user
  end

  it '購入できること' do
    tomato = create(:item, :published, name: 'トマト', price_excluding_tax: 100, tax_rate: 0.08)
    kyabetu = create(:item, :published, name: 'キャベツ', price_excluding_tax: 200, tax_rate: 0.08)
    create(:cart_item, cart: user.cart, item: tomato, quantity: 2)
    create(:cart_item, cart: user.cart, item: kyabetu, quantity: 1)
    create(:address, user:, name_kanji: 'テスト太郎')

    visit new_users_purchase_path

    expect(page).to have_content 'カート'
    expect(page).to have_content '小計'
    expect(page).to have_content '432'
    expect(page).to have_content '配送料'
    expect(page).to have_content '660'
    expect(page).to have_content '手数料'
    expect(page).to have_content '330'
    expect(page).to have_content '合計(税込)'
    expect(page).to have_content '1,422'

    find(:test_class, 'select-date-button').click
    find('button[tabindex="0"]').click
    select 'テスト太郎', from: "purchase[address_id]"

    click_on '購入する'
    expect(page).to have_content '商品を購入しました'
    expect(page).not_to have_content '数量変更'
  end

  it '配送日と住所が選択されていないと、エラーメッセージが出ること' do
    item = create(:item, :published, name: 'トマト', price_excluding_tax: 100, tax_rate: 0.08)
    create(:cart_item, cart: user.cart, item:)
    create(:address, user:, name_kanji: 'テスト太郎')

    visit new_users_purchase_path
    expect(page).to have_content 'トマト'

    click_on '購入する'
    expect(page).to have_content '希望配送日を入力してください'
    expect(page).to have_content 'お届け先を入力してください'

    find(:test_class, 'select-date-button').click
    find('button[tabindex="0"]').click
    select 'テスト太郎', from: "purchase[address_id]"

    click_on '購入する'
    expect(page).to have_content '商品を購入しました'
  end

  it '購入履歴が残ること' do
    tomato = create(:item, :published, name: 'トマト', price_excluding_tax: 100, tax_rate: 0.08)
    kyabetu = create(:item, :published, name: 'キャベツ', price_excluding_tax: 200, tax_rate: 0.08)
    create(:cart_item, cart: user.cart, item: tomato, quantity: 2)
    create(:cart_item, cart: user.cart, item: kyabetu, quantity: 1)
    create(:address, user:, name_kanji: 'テスト太郎')

    visit new_users_purchase_path
    find(:test_class, 'select-date-button').click
    find('button[tabindex="0"]').click
    select 'テスト太郎', from: "purchase[address_id]"
    click_on '購入する'
    expect(page).to have_content '商品を購入しました'

    visit users_purchases_path
    expect(page).to have_content '注文履歴'
    expect(page).to have_content '合計金額'
    expect(page).to have_content '1,422'

    find(:test_class, 'purchase-show-button').click
    expect(page).to have_content '送付先住所'
    expect(page).to have_content '注文詳細'
    expect(page).to have_content 'カート'
    expect(page).to have_content '小計'
    expect(page).to have_content '432'
    expect(page).to have_content '配送料'
    expect(page).to have_content '660'
    expect(page).to have_content '手数料'
    expect(page).to have_content '330'
    expect(page).to have_content '合計(税込)'
    expect(page).to have_content '1,422'
  end
end

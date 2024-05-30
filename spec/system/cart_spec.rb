require 'rails_helper'

describe 'カート機能', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it '商品をカートに入れれること' do
    create(:item, :published, name: 'トマト')
    create(:item, :published, name: 'カボチャ')

    visit root_path
    click_on 'カートに追加', match: :first

    expect(page).to have_content 'カート'
    expect(page).to have_content 'トマト'
    expect(page).not_to have_content 'カボチャ'
  end

  it '商品の個数を変更できること' do
    create(:item, :published, name: 'トマト', price_excluding_tax: 300)

    visit root_path
    click_on 'カートに追加'
    expect(page).to have_content 'カート'
    expect(page).to have_field('cart_item[quantity]', with: 1)

    select '2', from: "cart_item[quantity]"
    click_on '更新する'

    expect(page).to have_content '数量を変更しました'
    expect(page).to have_field('cart_item[quantity]', with: 2)
    expect(page).not_to have_field('cart_item[quantity]', with: 1)
  end

  it 'カートから商品を削除できること' do
    create(:item, :published, name: 'トマト')

    visit root_path
    click_on 'カートに追加'
    expect(page).to have_content 'トマト'

    accept_confirm { click_on '削除' }

    expect(page).to have_content '削除しました'
    expect(page).to have_content '現在カートに商品はありません'
    expect(page).not_to have_content 'トマト'
  end
end

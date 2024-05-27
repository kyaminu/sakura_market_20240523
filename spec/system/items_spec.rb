require 'rails_helper'

describe '商品ページ', type: :system do
  it '商品が表示されること' do
    create(:item, :published, name: 'トマト')
    create(:item, :published, name: 'カボチャ')
    create(:item, :not_published, name: 'キャペツ')

    visit root_path
    expect(page).to have_content 'トマト'
    expect(page).to have_content 'カボチャ'
    expect(page).not_to have_content 'キャペツ'
  end

  it '税込の価格で表示されること' do
    create(:item, :published, name: 'トマト', price_excluding_tax: 100)
    create(:item, :published, name: 'カボチャ', price_excluding_tax: 200)

    visit root_path
    expect(page).to have_content '¥108'
    expect(page).to have_content '¥216'
    expect(page).not_to have_content '100'
    expect(page).not_to have_content '200'
  end
end

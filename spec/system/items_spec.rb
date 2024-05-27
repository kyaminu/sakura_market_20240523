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
end

require 'rails_helper'

describe '商品ページ', type: :system do
  describe '一覧ページ' do
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

  describe '詳細ページ' do
    it '商品が表示されること' do
      item = create(:item, :published, name: 'トマト', description: '美味しいとまと')
      create(:item, :published, name: 'カボチャ', description: '美味しいカボチャ')

      visit item_path(item)
      expect(page).to have_content 'トマト'
      expect(page).to have_content '美味しいとまと'
      expect(page).not_to have_content 'カボチャ'
      expect(page).not_to have_content '美味しいカボチャ'
    end

    it '税込の価格で表示されること' do
      item = create(:item, :published, name: 'トマト', price_excluding_tax: 100)

      visit item_path(item)
      expect(page).to have_content '¥108'
      expect(page).not_to have_content '100'
    end
  end
end

require 'rails_helper'

describe '商品管理', type: :system do
  before do
    admin = create(:administrator)
    sign_in admin
  end

  it '新規追加できること' do
    visit new_administrators_item_path

    fill_in 'item[name]', with: 'トマト'
    fill_in 'item[description]', with: '美味しいトマト'
    fill_in 'item[price_excluding_tax]', with: '100'
    attach_file 'item[image]', Rails.root.join('spec/fixtures/files/images/test.jpeg')
    click_on '登録する'

    expect(page).to have_content '登録しました'
    expect(page).to have_content '商品一覧'
    expect(page).to have_content 'トマト'
  end

  it '編集できること' do
    item = create(:item, name: 'トマト')

    visit edit_administrators_item_path(item)
    fill_in 'item[name]', with: 'とまと'
    click_on '更新する'

    expect(page).to have_content '更新しました'
    expect(page).to have_content '商品一覧'
    expect(page).to have_content 'とまと'
    expect(page).not_to have_content 'トマト'
  end

  it '削除できること' do
    create(:item, name: 'トマト')

    visit administrators_root_path
    expect(page).to have_content '商品一覧'
    expect(page).to have_content 'トマト'
    accept_confirm { click_on '削除' }

    expect(page).to have_content '削除しました'
    expect(page).not_to have_content 'トマト'
  end
end

require 'rails_helper'

describe '管理ユーザ', type: :system do
  before do
    admin = create(:administrator)
    sign_in admin
  end

  it 'ユーザ新規追加ができること' do
    visit new_administrators_administrator_path

    fill_in 'administrator[email]', with: 'admin@test.com'
    fill_in 'administrator[password]', with: 'password'
    click_on '登録する'

    expect(page).to have_content '作成しました'
    expect(page).to have_content '管理ユーザ一覧'
    expect(page).to have_content 'admin@test.com'
  end

  it 'ユーザを編集できること' do
    admin = create(:administrator, email: 'admin@test.com')

    visit edit_administrators_administrator_path(admin)
    fill_in 'administrator[email]', with: 'change-email@test.com'
    fill_in 'administrator[password]', with: 'password'
    click_on '更新する'

    expect(page).to have_content '更新しました'
    expect(page).to have_content '管理ユーザ一覧'
    expect(page).to have_content 'change-email@test.com'
    expect(page).not_to have_content 'admin@test.com'
  end

  it 'ユーザを削除できること' do
    create(:administrator, email: 'admin@test.com')

    visit administrators_administrators_path
    expect(page).to have_content '管理ユーザ一覧'
    expect(page).to have_content 'admin@test.com'


    within('tr', text: 'admin@test.com') do
      accept_confirm { click_on '削除' }
    end
    expect(page).to have_content '削除しました'
    expect(page).not_to have_content 'admin@test.com'
  end
end

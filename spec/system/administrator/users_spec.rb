describe 'ユーザ管理', type: :system do
  before do
    admin = create(:administrator)
    sign_in admin
  end

  it '一覧が表示されること' do
    create(:user, name: 'テスト', email: 'test@example.com')
    create(:user, name: 'テスト2', email: 'test2@example.com')

    visit administrators_users_path
    expect(page).to have_content 'テスト'
    expect(page).to have_content 'test@example.com'
    expect(page).to have_content 'テスト2'
    expect(page).to have_content 'test2@example.com'
  end

  it '編集できること' do
    create(:user, name: 'テスト', email: 'test@example.com')

    visit administrators_users_path
    expect(page).to have_content 'テスト'
    expect(page).to have_content 'test@example.com'

    click_on '編集'
    fill_in 'user[name]', with: 'てすと'
    click_on '更新する'

    expect(page).to have_content '更新しました'
    expect(page).to have_content 'てすと'
    expect(page).to have_content 'test@example.com'
    expect(page).not_to have_content 'テスト'
  end
end

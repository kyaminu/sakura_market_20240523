describe '住所リスト', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it '新規登録ができること' do
    visit new_users_address_path

    fill_in 'address[name_kanji]', with: '佐藤太郎'
    fill_in 'address[name_kana]', with: 'さとうたろう'
    fill_in 'address[phone_number]', with: '09012345678'
    fill_in 'address[postal_code]', with: '1234567'
    select '兵庫', from: "address[prefecture_code]"
    fill_in 'address[city]', with: '神戸市'
    fill_in 'address[street]', with: '三宮'
    click_on '登録する'

    expect(page).to have_content '登録しました'
    expect(page).to have_content '佐藤太郎'
    expect(page).to have_content 'さとうたろう'
    expect(page).to have_content '09012345678'
    expect(page).to have_content '1234567'
    expect(page).to have_content '兵庫'
    expect(page).to have_content '神戸市'
    expect(page).to have_content '三宮'
  end

  it '編集できること' do
    address = create(:address, user:, street: '三宮')

    visit users_addresses_path
    expect(page).to have_content '三宮'

    visit edit_users_address_path(address)
    fill_in 'address[street]', with: '東灘'
    click_on '更新する'

    expect(page).to have_content '更新しました'
    expect(page).to have_content '東灘'
    expect(page).not_to have_content '三宮'
  end

  it '削除できること' do
    create(:address, user:, street: '三宮')

    visit users_addresses_path
    expect(page).to have_content '三宮'

    accept_confirm { click_on '削除' }

    expect(page).to have_content '削除しました'
    expect(page).not_to have_content '三宮'
  end
end

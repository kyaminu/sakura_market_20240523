describe 'カート機能', type: :system do
  describe 'ログイン済ユーザのカート機能' do
    before do
      user = create(:user, :with_cart)
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

  describe 'ゲストユーザーのカート機能' do
    describe '新規登録' do
      it 'カートに入れた商品が新規登録後も維持されること' do
        create(:item, :published, name: 'トマト')
        create(:item, :published, name: 'カボチャ')

        visit root_path
        click_on 'カートに追加', match: :first
        expect(page).to have_content 'カート'
        expect(page).to have_content 'トマト'
        expect(page).not_to have_content 'カボチャ'

        visit new_user_registration_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        find(:test_class, 'sign_up_button').click
        expect(page).to have_content 'アカウント登録が完了しました'

        visit cart_path
        expect(page).to have_content 'カート'
        expect(page).to have_content 'トマト'
        expect(page).not_to have_content 'カボチャ'
      end

      it '商品の個数も新規登録後に維持されること' do
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

        visit new_user_registration_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        find(:test_class, 'sign_up_button').click
        expect(page).to have_content 'アカウント登録が完了しました'

        visit cart_path
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

        visit new_user_registration_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        find(:test_class, 'sign_up_button').click
        expect(page).to have_content 'アカウント登録が完了しました'

        visit cart_path
        expect(page).to have_content '現在カートに商品はありません'
      end
    end

    describe 'アカウント持ち' do
      it 'ログイン中の商品有のカートと、ログイン前の商品有のカートが、ログインした後にカートの中身がマージされていること', js: true do
        create(:user, :with_cart, email: 'test@example.com', password: 'password')
        create(:item, :published, name: 'トマト')

        visit new_user_session_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        find(:test_class, 'login_button').click
        expect(page).to have_content 'ログインしました'

        visit root_path
        click_on 'カートに追加'
        expect(page).to have_content 'トマト'
        expect(page).to have_field('cart_item[quantity]', with: 1)

        click_on 'Log out'
        expect(page).to have_content 'ログアウトしました'
        click_on 'カートに追加'
        expect(page).to have_content 'トマト'
        expect(page).to have_field('cart_item[quantity]', with: 1)

        visit new_user_session_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        find(:test_class, 'login_button').click
        expect(page).to have_content 'ログインしました'

        visit cart_path
        expect(page).to have_content 'トマト'
        expect(page).to have_field('cart_item[quantity]', with: 2)
      end
    end
  end
end

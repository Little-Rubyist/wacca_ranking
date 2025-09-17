require 'rails_helper'

describe 'sign_up', type: :system, js: true do
  context 'ユーザー登録ページの表示' do
    before { visit sign_up_path }

    it 'ユーザー登録ページが表示される' do
      expect(page).to have_selector('h1', text: I18n.t('views.users.new'))
      expect(page).to have_current_path(sign_up_path, ignore_query: true)
    end

    it 'フォーム要素が正しく表示される' do
      expect(page).to have_field('user_name', type: 'text')
      expect(page).to have_field('user_display_name', type: 'text')
      expect(page).to have_field('user_password', type: 'password')
      expect(page).to have_field('user_password_confirmation', type: 'password')
      expect(page).to have_button(I18n.t('views.common.register_button'))
    end

    it 'フィールドの説明文が表示される' do
      expect(page).to have_text('英数字と-_のみ入力出来ます(大文字と小文字は区別しません)')
    end

    it '利用規約とプライバシーポリシーのリンクが表示される' do
      expect(page).to have_link('利用規約')
      expect(page).to have_link('プライバシーポリシー')
    end

    it '必須フィールドが設定されている' do
      name_field = find_field('user_name')
      password_field = find_field('user_password')
      password_confirmation_field = find_field('user_password_confirmation')

      expect(name_field['required']).to be_truthy
      expect(password_field['required']).to be_truthy
      expect(password_confirmation_field['required']).to be_truthy
    end
  end

  context 'ユーザー登録の成功' do
    before { visit sign_up_path }

    it '有効な情報でユーザー登録ができる' do
      fill_in 'user_name', with: 'test_user'
      fill_in 'user_display_name', with: 'Test User'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'

      expect {
        click_button I18n.t('views.common.register_button')
      }.to change(User, :count).by(1)

      expect(page).to have_content('ユーザーを登録しました')
      expect(page).to have_current_path(user_songs_path, ignore_query: true)
    end

    it 'ユーザー登録後に自動ログインされる' do
      fill_in 'user_name', with: 'auto_login_user'
      fill_in 'user_display_name', with: 'Auto Login User'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'

      click_button I18n.t('views.common.register_button')

      expect(page).to have_current_path(user_songs_path, ignore_query: true)
    end
  end

  context 'バリデーションエラー' do
    before { visit sign_up_path }

    it '必須フィールドが空の場合エラーが表示される' do
      click_button I18n.t('views.common.register_button')

      expect(page).to have_content('を入力してください')
      expect(page).to have_current_path(sign_up_path, ignore_query: true)
    end

    it 'パスワードと確認パスワードが一致しない場合エラーが表示される' do
      fill_in 'user_name', with: 'mismatch_user'
      fill_in 'user_display_name', with: 'Mismatch User'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'different_password'

      click_button I18n.t('views.common.register_button')

      expect(page).to have_content('パスワード(確認)とパスワードの入力が一致しません')
      expect(page).to have_current_path(sign_up_path, ignore_query: true)
    end

    it '既存ユーザーと同じ名前の場合エラーが表示される' do
      create(:user, name: 'existing_user')

      fill_in 'user_name', with: 'existing_user'
      fill_in 'user_display_name', with: 'Existing User'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'

      click_button I18n.t('views.common.register_button')

      expect(page).to have_content('IDはすでに存在します')
      expect(page).to have_current_path(sign_up_path, ignore_query: true)
    end

    it 'エラー発生時もフォームの値が保持される' do
      fill_in 'user_name', with: 'test_name'
      fill_in 'user_display_name', with: 'Test Display Name'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'different_password'

      click_button I18n.t('views.common.register_button')

      expect(find_field('user_name').value).to eq('test_name')
      expect(find_field('user_display_name').value).to eq('Test Display Name')
    end
  end

  context 'ログイン済みユーザーのリダイレクト' do
    it 'ログイン済みの場合はuser_songs_pathにリダイレクトされる' do
      user = create(:user, password: 'password123')
      log_in_as(user)

      visit sign_up_path

      expect(page).to have_current_path(user_songs_path, ignore_query: true)
    end
  end
end
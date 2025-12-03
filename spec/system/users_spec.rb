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

describe 'user_songs#index', type: :system, js: false do
  let!(:user) { create(:user, password: 'password123') }

  before do
    log_in_as(user)
  end

  context 'マイページの表示' do
    before do
      # actual music_ids
      [3008, 3034, 3020].each do |music_id|
        song = Song.find_by(music_id:)
        create(:user_song, user:, song:)
      end
      visit user_songs_path
    end

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: 'My Page')
      expect(page).to have_current_path(user_songs_path, ignore_query: true)
    end

    it '検索フォームが表示される' do
      expect(page).to have_field('q_song_difficulty_gteq', type: 'range')
      expect(page).to have_select('q_song_diff_type_eq')
      expect(page).to have_field('q_song_title_or_song_title_english_cont', type: 'search')
      expect(page).to have_select('q_user_scores_achieve_eq')
      expect(page).to have_select('q_song_genre_eq')
    end

    it 'フィルターコントロールが表示される' do
      expect(page).to have_field('q_is_favorite_true', type: 'checkbox')
      expect(page).to have_field('q_song_can_play_offline_true', type: 'checkbox')
      expect(page).to have_button(I18n.t('views.common.search_button'))
    end

    it 'リセットボタンが表示される' do
      expect(page).to have_selector('#reset-difficulty-value')
    end
  end

  context '検索機能' do
    let!(:high_level_song) { Song.find_by!(music_id: 3008) }
    let!(:low_level_song) { Song.find_by!(music_id: 3034) }
    let!(:medium_level_song) { Song.find_by!(music_id: 3020) }
    let!(:offline_song) { Song.find_by!(music_id: 2060) }

    before do
      create(:user_song, user:, song: high_level_song)
      create(:user_song, user:, song: low_level_song)
      create(:user_song, user:, song: medium_level_song, is_favorite: true)
      create(:user_song, user:, song: offline_song)

      visit user_songs_path
    end

    it 'レベル範囲検索で正しく絞り込める' do
      find('#q_song_difficulty_gteq').set('8')
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text(high_level_song.title)
      expect(page).to have_text(medium_level_song.title)
      expect(page).to have_text(offline_song.title)
      expect(page).not_to have_text('3.0')  # 低レベル楽曲は除外
    end

    it 'タイトル検索で正しく絞り込める' do
      fill_in 'q_song_title_or_song_title_english_cont', with: 'ヒトガタ'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('ヒトガタ')
      expect(page).to have_text('12.6')
      expect(page).to have_text('9.7')
      expect(page).to have_text('3.0')
      expect(page).not_to have_text('cœur')
    end

    it 'お気に入りフィルターで正しく絞り込める' do
      check 'q_is_favorite_true'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text(medium_level_song.title)
      expect(page).to have_text('9.7')   # お気に入りの中レベル
      expect(page).not_to have_text('3.0')
      expect(page).not_to have_text('12.6')
      expect(page).not_to have_text('cœur')
    end

    it 'オフライン曲フィルターで正しく絞り込める' do
      check 'q_song_can_play_offline_true'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text(offline_song.title)
      expect(page).to have_text('cœur')
      expect(page).not_to have_text('ヒトガタ')
    end

    it '複数の条件を組み合わせて検索できる' do
      find('#q_song_difficulty_gteq').set('8')
      check 'q_is_favorite_true'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text(medium_level_song.title)
      expect(page).to have_text('9.7')   # お気に入りかつ8以上
      expect(page).not_to have_text('3.0')   # レベル8未満
      expect(page).not_to have_text('12.6')  # 非お気に入り
      expect(page).not_to have_text('cœur')  # 非お気に入り
    end
  end

  context 'ログインが必要なページ' do
    it '未ログイン時はリダイレクトされる' do
      page.driver.submit :post, sign_out_path, {}
      visit user_songs_path

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end
  end
end

describe 'sign_in', type: :system, js: true do
  let!(:user) { create(:user, name: 'test_user', password: 'password123') }

  context 'ログインページの表示' do
    before { visit sign_in_path }

    it 'ログインページが表示される' do
      expect(page).to have_selector('h1', text: I18n.t('views.session.new'))
      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end

    it 'フォーム要素が正しく表示される' do
      expect(page).to have_field('session_name', type: 'text')
      expect(page).to have_field('session_password', type: 'password')
      expect(page).to have_button(I18n.t('views.session.login_button'))
    end

    it 'フィールドラベルが正しく表示される' do
      expect(page).to have_text(User.human_attribute_name(:name))
      expect(page).to have_text(User.human_attribute_name(:password))
    end
  end

  context 'ログインの成功' do
    before { visit sign_in_path }

    it '有効な認証情報でログインできる' do
      fill_in 'session_name', with: user.name
      fill_in 'session_password', with: 'password123'

      click_button I18n.t('views.session.login_button')

      expect(page).to have_current_path(user_songs_path, ignore_query: true)
    end
  end

  context 'ログインの失敗' do
    before { visit sign_in_path }

    it '無効なユーザー名の場合ログインできない' do
      fill_in 'session_name', with: 'invalid_user'
      fill_in 'session_password', with: 'password123'

      click_button I18n.t('views.session.login_button')

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end

    it '無効なパスワードの場合ログインできない' do
      fill_in 'session_name', with: user.name
      fill_in 'session_password', with: 'wrong_password'

      click_button I18n.t('views.session.login_button')

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end

    it '空のフィールドの場合ログインできない' do
      click_button I18n.t('views.session.login_button')

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end
  end

  context 'ログイン済みユーザーのアクセス' do
    it 'ログイン済みでもsign_inページにアクセスできる' do
      log_in_as(user)

      visit sign_in_path

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end
  end
end

describe 'users#show', type: :system, js: false do
  let!(:user) { create(:user, password: 'password123') }

  before do
    log_in_as(user)
  end

  context 'ユーザー詳細ページの表示' do
    before do
      # actual music_ids
      [2074, 2080, 2086].each do |music_id|
        song = Song.find_by!(music_id:)
        create(:user_song, user:, song:)
      end
      visit user_path(user)
    end

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: 'My Page')
      expect(page).to have_current_path(user_path(user), ignore_query: true)
    end

    it '検索フォームが表示される' do
      expect(page).to have_field('q_song_difficulty_gteq', type: 'range')
      expect(page).to have_select('q_song_diff_type_eq')
      expect(page).to have_field('q_song_title_cont', type: 'search')
      expect(page).to have_select('q_user_scores_achieve_eq')
    end

    it 'フィルターコントロールが表示される' do
      expect(page).to have_field('q_is_favorite_true', type: 'checkbox')
      expect(page).to have_field('q_song_can_play_offline_true', type: 'checkbox')
      expect(page).to have_button('検索')
    end

    it 'レベルリセットボタンが表示される' do
      expect(page).to have_text('リセット')
    end

    it 'テーブルヘッダーが正しく表示される' do
      expect(page).to have_text('タイトル')
      expect(page).to have_text('ジャンル')
      expect(page).to have_text('譜面定数')
      expect(page).to have_text('難易度')
      expect(page).to have_text('スコア')
      expect(page).to have_text('FC')
    end
  end

  context '検索機能' do
    let!(:high_level_song) { Song.find_by!(music_id: 3030, diff_type: 1) }
    let!(:low_level_song) { Song.find_by!(music_id: 3030, diff_type: 2) }
    let!(:medium_level_song) { Song.find_by!(music_id: 3030, diff_type: 3) }
    let!(:offline_song) { Song.find_by!(music_id: 2253) }

    before do
      create(:user_song, user:, song: high_level_song)
      create(:user_song, user:, song: low_level_song)
      create(:user_song, user:, song: medium_level_song, is_favorite: true)
      create(:user_song, user:, song: offline_song)

      visit user_path(user)
    end

    it 'レベル範囲検索で正しく絞り込める' do
      find('#q_song_difficulty_gteq').set('8')
      click_button '検索'

      expect(page).to have_text(high_level_song.title)
      expect(page).to have_text(medium_level_song.title)
      expect(page).to have_text(offline_song.title)
      expect(page).not_to have_text('3.0')  # 低レベル楽曲は除外
    end

    it 'タイトル検索で正しく絞り込める' do
      fill_in 'q_song_title_cont', with: 'ヒトガタ'
      click_button '検索'

      expect(page).to have_text('ヒトガタ')
      expect(page).to have_text('12.6')  # 高レベルのヒトガタ
      expect(page).to have_text('9.7')   # 中レベルのヒトガタ
      expect(page).to have_text('3.0')   # 低レベルのヒトガタ
      expect(page).not_to have_text('cœur')  # 他の楽曲は除外
    end

    it 'お気に入りフィルターで正しく絞り込める' do
      check 'q_is_favorite_true'
      click_button '検索'

      expect(page).to have_text(medium_level_song.title)
      expect(page).to have_text('9.7')   # お気に入りの中レベル
      expect(page).not_to have_text('3.0')   # 非お気に入り
      expect(page).not_to have_text('12.6')  # 非お気に入り
      expect(page).not_to have_text('cœur')  # 非お気に入り
    end

    it 'オフライン曲フィルターで正しく絞り込める' do
      check 'q_song_can_play_offline_true'
      click_button '検索'

      expect(page).to have_text(offline_song.title)
      expect(page).to have_text('cœur')
      expect(page).not_to have_text('ヒトガタ')  # オンライン楽曲は除外
    end
  end

  context 'アクセス制御' do
    it '未ログイン時はエラーが発生する' do
      page.driver.submit :post, sign_out_path, {}

      expect {
        visit user_path(user)
      }.to raise_error(NoMethodError, /undefined method `id' for nil:NilClass/)
    end

    it '他のユーザーのページにアクセスできる（認証制限なし）' do
      other_user = create(:user, name: 'other_user')
      visit user_path(other_user)

      expect(page).to have_current_path(user_path(other_user), ignore_query: true)
    end
  end
end

describe 'how_to', type: :system, js: false do
  context 'スコアインポート方法ページの表示' do
    before { visit how_to_path }

    it 'ページが正しく表示される' do
      expect(page).to have_current_path(how_to_path, ignore_query: true)
    end

    it 'HTMLインポートセクションが表示される' do
      expect(page).to have_selector('#how-to-import-html')
      expect(page).to have_text('HTMLファイルの保存とスコアのインポート')
    end

    it 'CSVインポートセクションが表示される' do
      expect(page).to have_selector('#how-to-import-csv')
      expect(page).to have_text('CSVファイルの保存とスコアのインポート')
    end

    it 'WACCAの公式サイトへのリンクが表示される' do
      expect(page).to have_link('https://wacca.marv-games.jp/web/music', href: 'https://wacca.marv-games.jp/web/music')
    end

    it 'WACCA RATING ANALYZERへのリンクが表示される' do
      expect(page).to have_link('WACCA RATING ANALYZER', href: 'https://shimmand.github.io/wacca-rating-analyzer/')
    end

    it 'settings ページへのリンクが表示される' do
      expect(page).to have_link('https://wacca.little-rubyist.com/users/settings')
    end

    it '注意書きが表示される' do
      expect(page).to have_text('PC, Android以外からはHTMLの保存が出来る保証が出来ません')
      expect(page).to have_text('必ず')
      expect(page).to have_text('「Web page, complete」を選択してください')
    end

    it 'インポート手順の説明が表示される' do
      expect(page).to have_text('Ctrl+SまたはCmd+Sを押すと')
      expect(page).to have_text('楽曲スコアインポート(HTML)のフォーム')
      expect(page).to have_text('楽曲スコアインポート(CSV)のフォーム')
    end
  end
end

describe 'users#setting', type: :system, js: false do
  let!(:user) { create(:user, password: 'password123') }

  before do
    log_in_as(user)
  end

  context '設定ページの表示' do
    before { visit settings_users_path }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: '設定')
      expect(page).to have_current_path(settings_users_path, ignore_query: true)
    end

    it 'HTMLインポートセクションが表示される' do
      expect(page).to have_text('楽曲スコアインポート(HTML)')
      expect(page).to have_text('WACCAサイトのHTMLから楽曲情報やスコアをインポートします')
      expect(page).to have_text('インポート元のHTMLは必ずCompleteなHTMLファイルにしてください')
      expect(page).to have_text('インポートされるもの：スコア，お気に入り設定，FC状況')
    end

    it 'CSVインポートセクションが表示される' do
      expect(page).to have_text('楽曲スコアインポート(CSV)')
      expect(page).to have_text('WACCA RATING ANALYZERからスコア情報をインポートします')
      expect(page).to have_text('CSVをエクスポートしたものをアップロードしてください')
      expect(page).to have_text('インポートされるもの：スコア')
    end

    it 'ユーザー情報セクションが表示される' do
      expect(page).to have_text('ユーザー情報')
      expect(page).to have_text('パスワード変更は開発者にご連絡ください')
    end

    it 'HTMLファイルアップロードフォームが表示される' do
      expect(page).to have_field('user_file', type: 'file')
      expect(page).to have_button('インポート')
    end

    it 'CSVファイルアップロードフォームが表示される' do
      within('.card:nth-child(2)') do
        expect(page).to have_field('user_file', type: 'file')
        expect(page).to have_button('インポート')
      end
    end

    it 'ユーザー情報編集フォームが表示される' do
      expect(page).to have_field('user_display_name', type: 'text')
      expect(page).to have_field('user_name', type: 'text')
      expect(page).to have_button('更新')
    end

    it 'how_toページへのリンクが表示される' do
      expect(page).to have_link('HTMLの保存とインポート方法について')
      expect(page).to have_link('CSVの保存とインポート方法について')
    end
  end

  context 'ログインが必要なページ' do
    it '未ログイン時はリダイレクトされる' do
      page.driver.submit :post, sign_out_path, {}
      visit settings_users_path

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end
  end
end
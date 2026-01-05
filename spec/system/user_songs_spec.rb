require 'rails_helper'

describe 'user_songs#show', type: :system, js: false do
  let!(:user) { create(:user, password: 'password123') }
  let!(:song) { Song.first }
  let!(:user_song) { create(:user_song, user: user, song: song, is_favorite: true) }

  before do
    log_in_as(user)
  end

  context '楽曲詳細ページの表示' do
    before { visit user_song_path(user_song) }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: '楽曲詳細')
      expect(page).to have_current_path(user_song_path(user_song), ignore_query: true)
    end

    it '楽曲情報が表示される' do
      expect(page).to have_text("タイトル：#{song.title}")
      expect(page).to have_text("ジャンル：#{Song.human_attribute_enum_value(:genre, song.genre)}")
      expect(page).to have_text("レベル：#{Song.human_attribute_enum_value(:diff_type, song.diff_type)}")
      expect(page).to have_text("難易度：#{song.difficulty}")
    end

    it 'お気に入りボタンが表示される' do
      expect(page).to have_button('お気に入り解除')
    end

    it 'スコア追加ボタンが表示される' do
      expect(page).to have_button('追加')
    end

    it 'スコア履歴セクションが表示される' do
      expect(page).to have_selector('h3', text: 'スコア履歴')
    end

    it 'スコア履歴のテーブルヘッダーが表示される' do
      expect(page).to have_text('プレイ日')
      expect(page).to have_text('スコア')
      expect(page).to have_text('FC')
      expect(page).to have_text('登録日時')
    end
  end

  context 'お気に入りでない楽曲の場合' do
    let!(:user_song_not_favorite) { create(:user_song, user: user, song: Song.second, is_favorite: false) }

    before { visit user_song_path(user_song_not_favorite) }

    it 'お気に入りボタンが表示される' do
      expect(page).to have_button('お気に入りする')
    end
  end

  context 'スコア履歴がある場合' do
    let!(:user_score) do
      user_song = create(:user_song, user: user, song: Song.third)
      create(:user_score, user_song: user_song, score: 950000, achieve: 'all_marvelous')
    end

    before { visit user_song_path(user_score.user_song) }

    it 'スコア情報が表示される' do
      expect(page).to have_text('950000')
      expect(page).to have_button('削除')
    end
  end

  context 'ログインが必要なページ' do
    it '未ログイン時はリダイレクトされる' do
      page.driver.submit :post, sign_out_path, {}
      visit user_song_path(user_song)

      expect(page).to have_current_path(sign_in_path, ignore_query: true)
    end
  end
end

describe 'user_songs#index', type: :system, js: false do
  let!(:user) { create(:user, password: 'password123') }

  before do
    log_in_as(user)
  end

  context 'マイページの基本表示' do
    let!(:song1) { Song.find_by!(music_id: 3008, diff_type: 'normal') } # Machinery of Avoid (Normal) 4.0
    let!(:song2) { Song.find_by!(music_id: 3034, diff_type: 'normal') } # D3LTA QOMPLEX (Normal) 4.0
    let!(:song3) { Song.find_by!(music_id: 3020, diff_type: 'normal') } # 最強STRONGER (Normal) 5.0

    before do
      create(:user_song, user:, song: song1)
      create(:user_song, user:, song: song2)
      create(:user_song, user:, song: song3)
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
      expect(page).to have_select('q_song_genre_eq')
      expect(page).to have_select('q_user_scores_achieve_eq')
    end

    it 'フィルターコントロールが表示される' do
      expect(page).to have_field('q_is_favorite_true', type: 'checkbox')
      expect(page).to have_field('q_song_can_play_offline_true', type: 'checkbox')
      expect(page).to have_button(I18n.t('views.common.search_button'))
    end

    it '難易度リセットボタンが表示される' do
      expect(page).to have_selector('#reset-difficulty-value')
    end

    it 'テーブルヘッダーが正しく表示される' do
      expect(page).to have_text(Song.human_attribute_name(:title))
      expect(page).to have_text(Song.human_attribute_name(:genre))
      expect(page).to have_text(Song.human_attribute_name(:difficulty))
      expect(page).to have_text(Song.human_attribute_name(:diff_type))
      expect(page).to have_text(UserScore.human_attribute_name(:score))
    end

    it 'ユーザーの楽曲が表示される' do
      expect(page).to have_text(song1.title)
      expect(page).to have_text(song2.title)
      expect(page).to have_text(song3.title)
    end

    it '楽曲詳細へのリンクが表示される' do
      expect(page).to have_link(song1.title)
    end
  end

  context '検索機能: 譜面定数フィルター' do
    let!(:low_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') }    # 4.0
    let!(:mid_song) { Song.find_by!(music_id: 3020, diff_type: 'normal') }    # 5.0
    let!(:high_song) { Song.find_by!(music_id: 3008, diff_type: 'hard') }     # 8.5

    before do
      create(:user_song, user:, song: low_song)
      create(:user_song, user:, song: mid_song)
      create(:user_song, user:, song: high_song)
      visit user_songs_path
    end

    it '譜面定数5.0以上で絞り込める' do
      find('#q_song_difficulty_gteq').set('5.0')
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('5.0')
      expect(page).to have_text('8.5')
      expect(page).not_to have_text('4.0')
    end

    it '譜面定数8.0以上で絞り込める' do
      find('#q_song_difficulty_gteq').set('8.0')
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('8.5')
      expect(page).not_to have_text('5.0')
      expect(page).not_to have_text('4.0')
    end
  end

  context '検索機能: 難易度フィルター' do
    let!(:normal_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') }
    let!(:hard_song) { Song.find_by!(music_id: 3008, diff_type: 'hard') }
    let!(:expert_song) { Song.find_by!(music_id: 3008, diff_type: 'expert') }

    before do
      create(:user_song, user:, song: normal_song)
      create(:user_song, user:, song: hard_song)
      create(:user_song, user:, song: expert_song)
      visit user_songs_path
    end

    it 'Normal難易度で絞り込める' do
      select Song.human_attribute_enum_value(:diff_type, 'normal'), from: 'q_song_diff_type_eq'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('4.0')
      expect(page).not_to have_text('8.5')
      expect(page).not_to have_text('12.7')
    end

    it 'Hard難易度で絞り込める' do
      select Song.human_attribute_enum_value(:diff_type, 'hard'), from: 'q_song_diff_type_eq'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('8.5')
      expect(page).not_to have_text('4.0')
      expect(page).not_to have_text('12.7')
    end
  end

  context '検索機能: タイトル検索' do
    let!(:machinery_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') } # Machinery of Avoid
    let!(:strongest_song) { Song.find_by!(music_id: 3020, diff_type: 'normal') } # 最強STRONGER

    before do
      create(:user_song, user:, song: machinery_song)
      create(:user_song, user:, song: strongest_song)
      visit user_songs_path
    end

    it '日本語タイトルで検索できる' do
      fill_in 'q_song_title_or_song_title_english_cont', with: '最強'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('最強STRONGER')
      expect(page).not_to have_text('Machinery of Avoid')
    end

    it '英語タイトルで検索できる' do
      fill_in 'q_song_title_or_song_title_english_cont', with: 'Machinery'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('Machinery of Avoid')
      expect(page).not_to have_text('最強STRONGER')
    end
  end

  context '検索機能: ジャンルフィルター' do
    let!(:variety_song) { Song.find_by!(music_id: 3020, diff_type: 'normal') }       # バラエティ
    let!(:hardcore_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') }      # HARDCORE TANO*C

    before do
      create(:user_song, user:, song: variety_song)
      create(:user_song, user:, song: hardcore_song)
      visit user_songs_path
    end

    it 'バラエティジャンルで絞り込める' do
      select Song.human_attribute_enum_value(:genre, variety_song.genre), from: 'q_song_genre_eq'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('最強STRONGER')
      expect(page).not_to have_text('Machinery of Avoid')
    end

    it 'HARDCORE TANO*Cジャンルで絞り込める' do
      select Song.human_attribute_enum_value(:genre, hardcore_song.genre), from: 'q_song_genre_eq'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('Machinery of Avoid')
      expect(page).not_to have_text('最強STRONGER')
    end
  end

  context '検索機能: お気に入りフィルター' do
    let!(:favorite_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') }
    let!(:normal_song) { Song.find_by!(music_id: 3020, diff_type: 'normal') }

    before do
      create(:user_song, user:, song: favorite_song, is_favorite: true)
      create(:user_song, user:, song: normal_song, is_favorite: false)
      visit user_songs_path
    end

    it 'お気に入りのみ表示できる' do
      check 'q_is_favorite_true'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('Machinery of Avoid')
      expect(page).not_to have_text('最強STRONGER')
    end
  end

  context '検索機能: オフライン曲フィルター' do
    let!(:offline_song) { Song.find_by!(music_id: 2253, diff_type: 'normal') }   # cœur (offline)
    let!(:online_song) { Song.find_by!(music_id: 3008, diff_type: 'normal') }    # Machinery of Avoid

    before do
      create(:user_song, user:, song: offline_song)
      create(:user_song, user:, song: online_song)
      visit user_songs_path
    end

    it 'オフライン曲チェックボックスが表示される' do
      expect(page).to have_field('q_song_can_play_offline_true', type: 'checkbox')
    end

    it 'オフライン曲が一覧に表示される' do
      expect(page).to have_text('cœur')
      expect(page).to have_text('Machinery of Avoid')
    end
  end

  context '検索機能: スコアがある場合の表示' do
    let!(:song_with_score) { Song.find_by!(music_id: 3008, diff_type: 'normal') }

    before do
      user_song = create(:user_song, user:, song: song_with_score)
      create(:user_score, user_song:, score: 980000, achieve: 'all_marvelous')
      visit user_songs_path
    end

    it 'スコアが表示される' do
      expect(page).to have_text('980000')
    end

    it 'FC状況が表示される' do
      expect(page).to have_text(UserScore.human_attribute_enum_value(:achieve, 'all_marvelous'))
    end
  end

  context '検索機能: 複数条件の組み合わせ' do
    let!(:target_song) { Song.find_by!(music_id: 3008, diff_type: 'hard') }      # 8.5, Hard, HARDCORE TANO*C
    let!(:other_song1) { Song.find_by!(music_id: 3008, diff_type: 'normal') }   # 4.0, Normal
    let!(:other_song2) { Song.find_by!(music_id: 3020, diff_type: 'hard') }     # 10.6, Hard, バラエティ

    before do
      create(:user_song, user:, song: target_song, is_favorite: true)
      create(:user_song, user:, song: other_song1, is_favorite: false)
      create(:user_song, user:, song: other_song2, is_favorite: true)
      visit user_songs_path
    end

    it '譜面定数8以上 + お気に入り + Hard難易度で絞り込める' do
      find('#q_song_difficulty_gteq').set('8.0')
      check 'q_is_favorite_true'
      select Song.human_attribute_enum_value(:diff_type, 'hard'), from: 'q_song_diff_type_eq'
      click_button I18n.t('views.common.search_button')

      expect(page).to have_text('8.5')
      expect(page).to have_text('10.6')
      expect(page).not_to have_text('4.0')
    end
  end

  context 'ページネーション' do
    before do
      # 26曲作成(ページサイズは25件)
      songs = Song.limit(26).to_a
      songs.each do |song|
        create(:user_song, user:, song:)
      end
      visit user_songs_path
    end

    it 'ページネーションが表示される' do
      expect(page).to have_selector('.pagination')
    end

    it '2ページ目に遷移できる' do
      within('.pagination') do
        click_link 'Next'
      end

      expect(page).to have_current_path(/page=2/)
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
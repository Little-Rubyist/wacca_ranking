require 'rails_helper'

describe 'songs#index', type: :system, js: false do
  let!(:song) { Song.first }

  context '楽曲一覧ページの表示' do
    before { visit songs_path }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: I18n.t('views.songs.title'))
      expect(page).to have_current_path(songs_path, ignore_query: true)
    end

    it 'ヒントメッセージが表示される' do
      expect(page).to have_text(I18n.t('views.songs.hint'))
    end

    it '検索フォームが表示される' do
      expect(page).to have_field('q_difficulty_gteq', type: 'range')
      expect(page).to have_select('q_diff_type_eq')
      expect(page).to have_select('q_genre_eq')
      expect(page).to have_field('q_title_or_title_english_cont', type: 'search')
    end

    it 'フィルターコントロールが表示される' do
      expect(page).to have_field('q_can_play_offline_true', type: 'checkbox')
      expect(page).to have_button(I18n.t('views.common.search_button'))
    end

    it 'リセットボタンが表示される' do
      expect(page).to have_selector('#reset-difficulty-value')
    end

    it 'テーブルヘッダーが正しく表示される' do
      expect(page).to have_text(Song.human_attribute_name(:title))
      expect(page).to have_text(Song.human_attribute_name(:genre))
      expect(page).to have_text(Song.human_attribute_enum_value(:diff_type, :normal))
      expect(page).to have_text(Song.human_attribute_enum_value(:diff_type, :hard))
      expect(page).to have_text(Song.human_attribute_enum_value(:diff_type, :expert))
      expect(page).to have_text(Song.human_attribute_enum_value(:diff_type, :inferno))
    end
  end

  context '検索機能' do
    before { visit songs_path }

    it 'レベル範囲検索の設定ができる' do
      find('#q_difficulty_gteq').set('5')
      expect(page).to have_field('q_difficulty_gteq')
    end

    it 'タイトル検索フィールドが使える' do
      fill_in 'q_title_or_title_english_cont', with: 'テスト'
      expect(find_field('q_title_or_title_english_cont').value).to eq('テスト')
    end

    it 'オフライン曲フィルターが使える' do
      check 'q_can_play_offline_true'
      expect(page).to have_checked_field('q_can_play_offline_true')
    end
  end
end

describe 'songs#show', type: :system, js: false do
  let!(:song) { Song.first }

  context '楽曲詳細ページの表示' do
    before { visit song_path(song) }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: 'Songs#show')
      expect(page).to have_current_path(song_path(song), ignore_query: true)
    end

    it '楽曲情報が表示される' do
      expect(page).to have_text(song.title)
      expect(page).to have_text(song.diff_type)
      expect(page).to have_text(song.difficulty.to_s)
      expect(page).to have_text(song.genre)
    end
  end
end
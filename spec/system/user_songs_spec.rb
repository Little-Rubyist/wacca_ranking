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
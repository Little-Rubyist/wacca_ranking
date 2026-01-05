require 'rails_helper'

describe 'home#index', type: :system, js: false do
  context 'ホームページの表示' do
    before { visit home_index_path }

    it 'ページが表示される' do
      expect(page).to have_selector('h1', text: 'Home#index')
      expect(page).to have_current_path(home_index_path, ignore_query: true)
    end

    it 'デフォルトメッセージが表示される' do
      expect(page).to have_text('Find me in app/views/home/index.html.haml')
    end
  end
end

describe 'home#policies', type: :system, js: false do
  context 'プライバシーポリシーページの表示' do
    before { visit policies_path }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: 'プライバシーポリシー')
      expect(page).to have_current_path(policies_path, ignore_query: true)
    end

    it '各条項のタイトルが表示される' do
      expect(page).to have_selector('h2', text: '第1条（個人情報）')
      expect(page).to have_selector('h2', text: '第2条（個人情報の収集方法）')
      expect(page).to have_selector('h2', text: '第3条（個人情報を収集・利用する目的）')
      expect(page).to have_selector('h2', text: '第4条（利用目的の変更）')
      expect(page).to have_selector('h2', text: '第5条（個人情報の第三者提供）')
    end

    it '開発者情報が表示される' do
      expect(page).to have_text('相生ゆら')
      expect(page).to have_text('Little-Rubyist@outlook.com')
      expect(page).to have_text('2022/09/27 制定')
    end

    it '個人情報取扱いの説明が表示される' do
      expect(page).to have_text('本サービスの提供・運営のため')
      expect(page).to have_text('ユーザーからのお問い合わせに回答するため')
    end
  end
end

describe 'home#agreement', type: :system, js: false do
  context '利用規約ページの表示' do
    before { visit agreement_path }

    it 'ページタイトルが表示される' do
      expect(page).to have_selector('h1', text: '利用規約')
      expect(page).to have_current_path(agreement_path, ignore_query: true)
    end

    it '各条項のタイトルが表示される' do
      expect(page).to have_selector('h2', text: '第１条（本規約の適用等）')
      expect(page).to have_selector('h2', text: '第２条（本サイトの内容等）')
      expect(page).to have_selector('h2', text: '第３条（利用登録）')
      expect(page).to have_selector('h2', text: '第６条（禁止事項）')
    end

    it 'サイト説明が表示される' do
      expect(page).to have_text('アーケードゲーム「WACCA」のスコア管理サイト')
      expect(page).to have_text('スコア管理等、各種機能を提供するサイトです')
    end

    it '開発者情報が表示される' do
      expect(page).to have_text('相生ゆら')
      expect(page).to have_text('2022/09/27 制定')
      expect(page).to have_text('2023/01/05 改定')
    end

    it '禁止事項の説明が表示される' do
      expect(page).to have_text('知的財産権（著作権、意匠権、特許権、実用新案権、商標権等）その他の権利を侵害する行為')
      expect(page).to have_text('営業、政治、宗教を目的とする行為')
    end
  end
end

describe 'home#information', type: :system, js: false do
  context 'お知らせページの表示' do
    before { visit information_path }

    it 'ページが表示される' do
      expect(page).to have_current_path(information_path, ignore_query: true)
    end
  end
end

describe 'home#sponsors', type: :system, js: false do
  context 'お布施ページの表示' do
    before { visit sponsors_path }

    it 'ページが表示される' do
      expect(page).to have_current_path(sponsors_path, ignore_query: true)
    end
  end
end

describe 'gallery pages', type: :system, js: false do
  context 'gallery/songs' do
    before { visit '/gallery/songs' }

    it 'ページが表示される' do
      expect(page).to have_current_path('/gallery/songs', ignore_query: true)
    end
  end

  context 'gallery/icons' do
    before { visit '/gallery/icons' }

    it 'ページが表示される' do
      expect(page).to have_current_path('/gallery/icons', ignore_query: true)
    end
  end

  context 'gallery/plates' do
    before { visit '/gallery/plates' }

    it 'ページが表示される' do
      expect(page).to have_current_path('/gallery/plates', ignore_query: true)
    end
  end
end
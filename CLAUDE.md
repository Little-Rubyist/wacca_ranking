# development guide for Claude Code
原則として、日本語で応答してください。

## プロジェクト概要
このリポジトリは、WACCAという音楽ゲームのスコアを記録し、管理するためのサイトのソースコードリポジトリです。

このファイルに記述されていないその他の項目に関しては、README.mdを参照してください。

### 技術スタック
- **言語**: Ruby
- **フレームワーク**: Ruby on Rails
- **データベース**: MySQL
- **ランタイム**: Puma、Docker、AWS EC2
- **型チェック**: RBS & Steep
- **テストフレームワーク**: RSpec
- **パッケージマネージャー**: Bundler (Ruby)

## 重要なコマンド
### テスト
```bash
$ bundle exec rspec # 全てのテストを実行する
$ bundle exec rspec spec/models # 特定のディレクトリ以下のテストを実行する
$ bundle exec rspec spec/system/home_spec.rb # 特定のファイルのテストを実行する
$ bundle exec rspec spec/system/home_spec.rb spec/system/songs_spec.rb # 複数のファイルのテストを実行できる
$ bundle exec rspec spec/system/home_spec.rb:4 # 特定のcontextまたはテストケースを行番号指定で実行する
```

## 開発中に守るべきこと
- 原則として、t-wadaさんが行うテスト駆動開発(TDD)の手順に従うものとします。

- リポジトリのtmp/CLAUDE_PLAN.mdへ作業の実行計画や指示された作業上で注意するべき点をマークダウン形式で随時出力、編集し、tmp/CLAUDE_PLAN.mdを参照しながら実際の作業を進めなければなりません。
- tmp/CLAUDE_PLAN.mdは下記の項目から成るものとします。
    - 行う作業の目的・概要
    - おおまかな作業手順
        - 複数の作業対象がある場合、この項目には1つの作業対象に対して行う手順を書く
    - 作業を行う際に気を付けるべき点
    - 作業対象をチェックボックス形式で列挙し、完了したものには一つ完了するたびにチェックを入れる

- テストのfailする件数が増えるような変更は、テストケースを追加または修正する場合にのみ許されます。つまり、実装を変更する場合、その時点で記述してあるテストのうち、それまでpassしていたテストがfailしてはならず、また少なくともfailする件数が減らなければなりません。
- 一連のtodoが完了した最終状態においては、変更した箇所に関係する全てのテストがpassしていなければなりません。

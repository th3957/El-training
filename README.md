# El-training
[![Ruby](https://img.shields.io/badge/Ruby-2.5.3-red.svg)](https://docs.ruby-lang.org/ja/2.5.0/doc/index.html)
[![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-5.2.1-red.svg)](https://guides.rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-9.5.14-blue.svg)](https://www.postgresql.org/)

Ruby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

## アプリケーションの概要

&nbsp; &nbsp; &nbsp;現時点でタスク登録機能、ソート機能、進捗ステータス表示機能を実装しています。  
&nbsp; &nbsp; &nbsp;今後、優先順位表示機能、ラベリング機能、ユーザー登録機能、ユーザー管理機能を追加していきます。  
&nbsp; &nbsp; &nbsp;さらに、追加機能に対してソートおよび検索機能を実装していきます。


## 開発環境
- Windows 10
- VirtualBox 5.2.22
- Vagrant 2.2.0
- Ubuntu 16.04.5

## セットアップ

1. GitHubからクローンをおこないます。

```
    git clone https://github.com/th3957/El-training
```

2. rbenvがインストールされていない場合、以下のコマンドを実行してください。  
（実行環境に既にrbenvがインストールされている方は、このステップは省略してください。）

```
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    exec $SHELL -l
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    rbenv install 2.5.3
    rbenv rehash
```

2. 生成されたアプリケーションのディレクトリに移動します。

```
    cd El-training
```

3. bundlerがインストールされていない場合、以下のコマンドを実行してください。  
（既にインストールされている方は、このステップは省略してください。）

```
    rbenv exec gem install bundler
```

3. Gemのインストールをおこないます。

```ruby
    bundle install --path vendor/bundler
```

4. データベースの作成とマイグレーションをおこないます。

```ruby
    bundle exec rails db:create
    bundle exec rails db:migrate
```

5. サーバーを起動します。

```ruby
    bundle exec rails s
```

6. ブラウザで以下のURLを開くと、アプリケーションのページへアクセスできます。

    <http://localhost:3000/>

## テーブル設計
| モデル名 | カラム名 | データ型 |
|:-:|:-:|:-:|
|User|name|string|
||email|string|
||password_digest|string|
||created_at|string|
||updated_at|string|
|Task|title|string|
||contents|text|
||deadline|datetime|
||status|integer|
||status|index|
||priority|integer|
||priority|index|
||created_at|datetime|
||updated_at|datetime|
||user_id|integer|
||user_id(FK)|index|
|Labeling|task_id|integer|
||label_id|integer|
||created_at|datetime|
||updated_at|datetime|
||task_id(FK)|index|
||label_id(FK)|index|
|Label|title|string|
||Labelcolor|integer|
||created_at|datetime|
||updated_at|datetime|
||user_id|integer|

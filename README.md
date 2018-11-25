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
- Ubuntu 16.04.5
- Vagrant 2.2.0
- VirtualBox 5.2.22

## セットアップ

0. このアプリケーションはPostgreSQLを使用しています。  
実行環境にPostgreSQLがインストールされていない方は、[こちら](https://www.postgresql.org/download/)のページからお使いのOSにあわせて  
最新版のダウンロードをおこない、インストールしてください。  

1. GitHubからクローンをおこないます。

```
    git clone https://github.com/th3957/El-training
```

2. rbenvがインストールされていない場合、以下のコマンドを実行してください。  
（既にrbenvがインストールされている方は、このステップは省略してください。）

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
（既にbundlerがインストールされている方は、このステップは省略してください。）

```ruby
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

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<http://localhost:3000/>

## テーブル設計
| モデル名 | カラム名 | &nbsp; データ型 &nbsp; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| モデル名 | &nbsp; &nbsp; &nbsp; カラム名 &nbsp; &nbsp; &nbsp; | &nbsp; データ型 &nbsp; |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|User|name|string||Labeling|task_id|integer|
|┣|email|string||┣|label_id|integer|
|┣|password_digest|string||┣|created_at|datetime|
|┣|created_at|string||┣|updated_at|datetime|
|┗|updated_at|string||┣|task_id(FK)|index|
|Task|title|string||┗|label_id(FK)|index|
|┣|title|index||Label|title|string|
|┣|contents|text||┣|Labelcolor|integer|
|┣|deadline|datetime||┣|created_at|datetime|
|┣|status|integer||┣|updated_at|datetime|
|┣|status|index||┗|user_id|integer|
|┣|priority|integer|||||
|┣|priority|index|||||
|┣|created_at|datetime|||||
|┣|updated_at|datetime|||||
|┣|user_id|integer|||||
|┗|user_id(FK)|index|||||

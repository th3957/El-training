# El-training
[![Ruby](https://img.shields.io/badge/Ruby-2.5.3-red.svg)](https://docs.ruby-lang.org/ja/2.5.0/doc/index.html)
[![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-5.2.1-red.svg)](https://guides.rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-9.5.14-blue.svg)](https://www.postgresql.org/)

Ruby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

## アプリケーションの概要

&nbsp; &nbsp; &nbsp;タスク管理システムのアプリケーションです。  
&nbsp; &nbsp; &nbsp;タスク管理機能、タスクラベル添付機能、ユーザー管理機能を実装しています。  
&nbsp; &nbsp; &nbsp;また、作成されたタスクのソート・検索機能等が使用可能です。  

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

4. データベースの作成とマイグレーション、シードデータの作成をおこないます。

```ruby
    bundle exec rails db:create
    bundle exec rails db:migrate
    bundle exec rails db:seed
```

5. サーバーを起動します。

```ruby
    bundle exec rails s
```

6. ブラウザで以下のURLを開くと、アプリケーションのページへアクセスできます。  
管理ユーザーは Eメール：1@gmail.com パスワード：111111 、  
一般ユーザーは Eメール：2@gmail.com パスワード：222222 でログインしてください。

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<http://localhost:3000/>

## テーブル設計
| モデル名 | カラム名 | &nbsp; データ型 &nbsp; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| モデル名 | &nbsp; &nbsp; &nbsp; カラム名 &nbsp; &nbsp; &nbsp; | &nbsp; データ型 &nbsp; |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|User|name|string||Labeling|task_id|bigint|
|┣|email|string||┣|label_id|bigint|
|┣|email|index||┣|created_at|datetime|
|┣|password_digest|string||┗|updated_at|datetime|
|┣|role|integer|
|┣|created_at|datetime||Label|title|string|
|┗|updated_at|datetime||┣|created_at|datetime|
|||||┗|updated_at|datetime|
|Task|title|string|
|┣|title|index|
|┣|contents|text|
|┣|deadline|datetime|
|┣|status|integer|
|┣|status|index|
|┣|priority|integer|
|┣|priority|index|
|┣|created_at|datetime|
|┣|updated_at|datetime|
|┣|user_id|bigint|
|┗|user_id(FK)|index|

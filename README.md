# El-training
[![Ruby](https://img.shields.io/badge/Ruby-2.5.3-red.svg)](https://docs.ruby-lang.org/ja/2.5.0/doc/index.html)
[![Rails](https://img.shields.io/badge/Rails-5.2.1-red.svg)](https://guides.rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-9.5.14-blue.svg)](https://www.postgresql.org/)

Ruby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

## アプリケーションの概要

&nbsp; &nbsp; &nbsp;現時点でタスク登録機能を実装しています。

&nbsp; &nbsp; &nbsp;進捗ステータス表示、優先順位表示、検索、ソート、ラベル、

&nbsp; &nbsp; &nbsp;ユーザー登録、ユーザー管理機能を実装していきます。

## セットアップ

    git clone https://github.com/th3957/El-training
    cd El-training
    bundle install --path vendor/bundler
    rails db:create db:migrate
    rails s

## テーブル設計
- Userモデル
    - name ： string
    - email ： string
    - password_digest ： string
    - created_at ： datetime
    - updated_at ： datetime

- Taskモデル
    - tasktitle ： string
    - contents ： ~~varchar(n)~~ text
    - deadline ： datetime
    - priority（優先順位の判定） ： ~~smallint~~ integer ※退避中
    - state（未着手・着手・完了の判定） ： ~~smallint~~ integer ※退避中
    - created_at ： datetime
    - updated_at ： datetime
    - user_id ： integer
    - user_id(FK) ： index

- Labelingモデル
    - task_id : integer
    - label_id : integer
    - created_at : datetime
    - updated_at : datetime
    - task_id(FK) : index
    - label_id(FK) : index

- Labelモデル
    - labeltitle ： string
    - Labelcolor(背景色の判定) ： ~~smallint~~ integer
    - created_at ： datetime
    - updated_at ： datetime
    - user_id ： integer

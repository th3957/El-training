# El-training
Ruby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

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
    - priority（優先順位の判定） ： ~~smallint~~ integer
    - state（未着手・着手・完了の判定） ： ~~smallint~~ integer
    - created_at ： datetime
    - updated_at ： datetime
    - user_id ： integer
    - user_id(FK) ： index

- Labelingモデル
    - task_id　:　integer
    - label_id　:　integer
    - created_at　:　datetime
    - updated_at　:　datetime
    - task_id(FK)　:　index
    - label_id(FK)　:　index

- Labelモデル
    - labeltitle ： string
    - Labelcolor(背景色の判定) ： ~~smallint~~ integer
    - created_at ： datetime
    - updated_at ： datetime
    - user_id ： integer

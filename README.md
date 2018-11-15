# El-training
Ruby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

## テーブル設計
モデル名(テーブル名) - カラム名 - データ型

User - name - string
User - email - string
User - password_digest - string
User - created_at - datetime
User - updated_at - datetime

Task - tasktitle - string
Task - contents - varchar(n)
Task - deadline - datetime
Task - priority（優先順位の判定） - smallint
Task - state（未着手・着手・完了の判定） - smallint
Task - created_at - datetime
Task - updated_at - datetime
Task - user_id - integer
Task - user_id(FK) - index

Labeling - task_id - integer
Labeling - label_id - integer
Labeling - created_at - datetime
Labeling - updated_at - datetime
Labeling - task_id(FK) - index
Labeling - label_id(FK) - index

Label - labeltitle - string
Label - Labelcolor(背景色の判定) - smallint
Label - created_at - datetime
Label - updated_at - datetime
Label - user_id - integer

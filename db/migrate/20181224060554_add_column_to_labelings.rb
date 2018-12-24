class AddColumnToLabelings < ActiveRecord::Migration[5.2]
  def change
    add_column :labelings, :label_id, :bigint, null: false
    add_column :labelings, :task_id, :bigint, null: false
  end
end

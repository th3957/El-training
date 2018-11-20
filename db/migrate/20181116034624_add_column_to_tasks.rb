class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :string, null: false, limit: 255
    add_column :tasks, :contents, :text, null: false
    add_column :tasks, :deadline, :datetime, null: false
    add_column :tasks, :priority, :integer, null: false
    add_column :tasks, :state, :integer, null: false
  end
end

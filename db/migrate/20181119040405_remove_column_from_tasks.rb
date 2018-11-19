class RemoveColumnFromTasks < ActiveRecord::Migration[5.2]
  def down
    remove_columns :tasks, :priority, :state
  end
end

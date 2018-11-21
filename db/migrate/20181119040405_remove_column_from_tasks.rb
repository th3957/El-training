class RemoveColumnFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_columns :tasks, :priority, :state
  end
end

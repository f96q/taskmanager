class AddProjectIdToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :project, index: true
    change_column :tasks, :project_id, :integer, null: false
    remove_column :tasks, :user_id
  end
end

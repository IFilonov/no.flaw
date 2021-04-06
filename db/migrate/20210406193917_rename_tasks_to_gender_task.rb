class RenameTasksToGenderTask < ActiveRecord::Migration[6.1]
  def change
    rename_table :tasks, :gender_tasks
  end
end

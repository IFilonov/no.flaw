class CreateNewTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.date :planned_time
      t.date :started_time
      t.date :finished_time
      t.references :gender_task, null: false, foreign_key: true

      t.timestamps
    end
    add_reference :tasks, :userable, polymorphic: true, index: true
  end
end

class AddGenderToTasks < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE task_gender AS ENUM ('female', 'male', 'none');
      CREATE TYPE task_level AS ENUM ('low', 'middle', 'high', 'none');
    SQL
    add_column :tasks, :gender, :task_gender
    add_column :tasks, :level, :task_level
    add_column :pairs, :level, :task_level
    add_index :tasks, :gender
    add_index :tasks, :level
  end

  def down
    remove_column :tasks, :gender
    remove_column :tasks, :level
    remove_column :pairs, :level
    execute <<-SQL
      DROP TYPE task_gender;
      DROP TYPE task_level;
    SQL
  end
end

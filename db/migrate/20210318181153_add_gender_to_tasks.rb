class AddGenderToTasks < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE gender AS ENUM ('female', 'male', 'both');
      CREATE TYPE level AS ENUM ('low', 'middle', 'high', 'none');
    SQL
    add_column :tasks, :gender, :gender
    add_column :tasks, :level, :level
    add_column :pairs, :level, :level
    add_index :tasks, :gender
    add_index :tasks, :level
  end

  def down
    remove_column :tasks, :gender
    remove_column :tasks, :level
    remove_column :pairs, :level
    execute <<-SQL
      DROP TYPE gender;
      DROP TYPE level;
    SQL
  end
end

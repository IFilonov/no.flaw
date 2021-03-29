class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_reference :tasks, :category, null: false, foreign_key: true
  end
end

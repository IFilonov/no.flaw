class CreatePairs < ActiveRecord::Migration[6.0]
  def change
    create_table :pairs do |t|
      t.references :male, null: false, foreign_key: true
      t.references :female, null: false, foreign_key: true

      t.timestamps
    end
  end
end

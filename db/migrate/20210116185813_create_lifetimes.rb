class CreateLifetimes < ActiveRecord::Migration[6.0]
  def change
    create_table :lifetimes do |t|
      t.string :taboo_date
      t.string :fire_date
      t.references :dateable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

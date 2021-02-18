class AddFemaleToMale < ActiveRecord::Migration[6.0]
  def change
    add_reference :males, :female, null: true, foreign_key: true
  end
end

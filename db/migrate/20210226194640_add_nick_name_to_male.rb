class AddNickNameToMale < ActiveRecord::Migration[6.0]
  def change
    add_column :males, :nickname, :string
    add_column :females, :nickname, :string
  end
end

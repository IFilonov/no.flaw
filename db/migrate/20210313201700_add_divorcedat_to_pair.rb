class AddDivorcedatToPair < ActiveRecord::Migration[6.1]
  def change
    add_column :pairs, :divorced_at, :date
  end
end

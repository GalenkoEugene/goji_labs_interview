class AddIndexToTypeOnUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :type
  end
end

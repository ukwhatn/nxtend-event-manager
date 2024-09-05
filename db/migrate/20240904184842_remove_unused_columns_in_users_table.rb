class RemoveUnusedColumnsInUsersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :school_name
    remove_column :users, :graduation_year
    remove_column :users, :circle_name
  end
end

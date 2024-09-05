class RemoveUnusedColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :description, :text
    remove_column :events, :location, :string
    remove_column :events, :start_at, :datetime
    remove_column :events, :end_at, :datetime
    remove_column :events, :is_cancelled, :boolean

    remove_column :event_programs, :description, :text
    remove_column :event_programs, :start_time, :datetime
    remove_column :event_programs, :end_time, :datetime
    remove_column :event_programs, :location, :string

    remove_column :kc32024_stamps, :description, :text
  end
end

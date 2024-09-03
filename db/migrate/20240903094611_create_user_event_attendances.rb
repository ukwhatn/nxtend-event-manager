class CreateUserEventAttendances < ActiveRecord::Migration[7.2]
  def change
    create_table :user_event_attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end

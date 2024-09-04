class CreateEventPrograms < ActiveRecord::Migration[7.2]
  def change
    create_table :event_programs do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :location, null: false
      t.string :attendance_token, null: false
      t.string :public_id, null: false
      t.timestamps

      t.index :attendance_token, unique: true
      t.index :public_id, unique: true
    end
  end
end

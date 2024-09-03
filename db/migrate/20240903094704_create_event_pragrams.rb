class CreateEventPragrams < ActiveRecord::Migration[7.2]
  def change
    create_table :event_pragrams do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.timestamps
    end
  end
end

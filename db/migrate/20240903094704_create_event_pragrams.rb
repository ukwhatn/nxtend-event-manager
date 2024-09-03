class CreateEventPragrams < ActiveRecord::Migration[7.2]
  def change
    create_table :event_pragrams do |t|
      t.timestamps
    end
  end
end

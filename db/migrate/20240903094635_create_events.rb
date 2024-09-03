class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :description, null: false
      t.datetime :location, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.datetime :is_cancelled, null: false, default: false
      t.timestamps
    end
  end
end

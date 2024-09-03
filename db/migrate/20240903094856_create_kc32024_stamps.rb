class CreateKc32024Stamps < ActiveRecord::Migration[7.2]
  def change
    create_table :kc32024_stamps do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.string :collection_token, null: false
      t.timestamps

      t.index :collection_token, unique: true
    end
  end
end

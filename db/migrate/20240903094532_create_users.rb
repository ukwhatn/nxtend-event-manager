class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.bigint :discord_id, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :email, null: false
      t.string :school_name, null: true
      t.integer :graduation_year, null: true
      t.string :circle_name, null: true
      t.timestamps
    end
  end
end

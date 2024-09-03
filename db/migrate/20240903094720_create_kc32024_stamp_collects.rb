class CreateKc32024StampCollects < ActiveRecord::Migration[7.2]
  def change
    create_table :kc32024_stamp_collects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kc32024_stamp, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateKc32024LotteryNumbers < ActiveRecord::Migration[7.2]
  def change
    create_table :kc32024_lottery_numbers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :number, null: false
      t.timestamps
    end
  end
end

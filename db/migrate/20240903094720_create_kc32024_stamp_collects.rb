class CreateKc32024StampCollects < ActiveRecord::Migration[7.2]
  def change
    create_table :kc32024_stamp_collects do |t|
      t.timestamps
    end
  end
end

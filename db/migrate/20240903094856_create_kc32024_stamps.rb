class CreateKc32024Stamps < ActiveRecord::Migration[7.2]
  def change
    create_table :kc32024_stamps do |t|
      t.timestamps
    end
  end
end

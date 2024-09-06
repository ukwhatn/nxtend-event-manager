class AddIsRequiredToKc32024Stamps < ActiveRecord::Migration[7.2]
  def change
    add_column :kc32024_stamps, :is_required, :boolean, null: false, default: false
  end
end

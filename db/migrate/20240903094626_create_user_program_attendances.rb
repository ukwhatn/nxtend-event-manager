class CreateUserProgramAttendances < ActiveRecord::Migration[7.2]
  def change
    create_table :user_program_attendances do |t|
      t.timestamps
    end
  end
end

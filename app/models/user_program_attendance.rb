class UserProgramAttendance < ApplicationRecord
  belongs_to :user
  belongs_to :event_program
end

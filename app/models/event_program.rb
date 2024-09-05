class EventProgram < ApplicationRecord
  validates :name, presence: true
  validates :public_id, presence: true, uniqueness: true
  validates :attendance_token, presence: true, uniqueness: true

  belongs_to :event
  has_many :user_program_attendances, dependent: :destroy
  has_many :users, through: :user_program_attendances

  def self.find_by_public_id(public_id)
    EventProgram.find_by(public_id: public_id)
  end

  def self.find_by_attendance_token(attendance_token)
    EventProgram.find_by(attendance_token: attendance_token)
  end

  def check_public_id_duplication
    EventProgram.find_by_public_id(public_id).nil? && Event.find_by_public_id(public_id).nil?
  end

  def check_attendance_token_duplication
    EventProgram.find_by_attendance_token(attendance_token).nil? && Event.find_by_attendance_token(attendance_token).nil?
  end
end

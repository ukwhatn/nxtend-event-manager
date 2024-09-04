class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :is_cancelled, inclusion: { in: [true, false] }
  validates :attendance_token, presence: true, uniqueness: true
  validates :public_id, presence: true, uniqueness: true

  has_many :event_programs, dependent: :destroy
  has_many :user_event_attendances, dependent: :destroy
  has_many :users, through: :user_event_attendances

  def self.find_by_public_id(public_id)
    Event.find_by(public_id: public_id)
  end

  def self.find_by_attendance_token(attendance_token)
    Event.find_by(attendance_token: attendance_token)
  end

  def check_public_id_duplication
    Event.find_by_public_id(public_id).nil? && EventProgram.find_by_public_id(public_id).nil?
  end
end

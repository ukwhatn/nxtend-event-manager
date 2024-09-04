class EventProgram < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :public_id, presence: true, uniqueness: true

  belongs_to :event
  has_many :user_program_attendances, dependent: :destroy
  has_many :users, through: :user_program_attendances

  def self.find_by_public_id(public_id)
    EventProgram.find_by(public_id: public_id)
  end

  def check_public_id_duplication
    EventProgram.find_by_public_id(public_id).nil? && Event.find_by_public_id(public_id).nil?
  end
end

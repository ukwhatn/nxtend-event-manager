class User < ApplicationRecord
  validates :discord_id, presence: true, uniqueness: true

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :user_event_attendances, dependent: :destroy
  has_many :events, through: :user_event_attendances

  has_many :user_program_attendances, dependent: :destroy
  has_many :event_programs, through: :user_program_attendances

  has_many :kc32024_stamp_collects, dependent: :destroy
  has_many :kc32024_stamps, through: :kc32024_stamp_collects
  has_one :kc32024_lottery_number, dependent: :destroy

  def self.find_by_discord_id(discord_id)
    User.find_by(discord_id: discord_id)
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_name_kana
    "#{last_name_kana} #{first_name_kana}"
  end

  def self.get_user_from_session(session)
    if session[:user_id].present?
      User.find_by(id: session[:user_id])
    else
      nil
    end
  end

end
